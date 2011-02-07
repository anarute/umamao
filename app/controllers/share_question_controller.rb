# This controller is used to share content on other websites, such as
# posting a question on Facebook.

class ShareQuestionController < ApplicationController
  before_filter :login_required
  before_filter :check_connections

  def new
    @question = Question.find_by_id(params[:question])
    respond_to do |format|
      format.js do
        html = {
          :question => @question,
          :where => params[:where]
        }
        if params[:where] == "twitter"
          bitly = Bitly.new(AppConfig.bitly[:username], AppConfig.bitly[:apikey])
          html[:link] = bitly.shorten(question_url(@question)).short_url
        end
        render :json => {
          :success => true,
          :html => (render_cell :share_question, :display, html)
        }
      end
    end
  end

  def create
    @body = params[:body]
    @question = Question.find_by_id(params[:question])
    @link = question_url(@question)
    status = :success

    case params[:where]
    when "facebook"
      begin
        graph = current_user.facebook_connection
        # FIXME: how can we get an image url inside a controller?
        graph.put_wall_post(@body, :link => @link,
                            :picture => AppConfig.site + "/images/logosquare.png")
        status = :success
        message = I18n.t("questions.show.share_success", :site => "Facebook")
        track_event(:shared_question, :where => "facebook")
      rescue Koala::Facebook::APIError
        status = :needs_permission
        session["omniauth_return_url"] = question_path(@question)
      end
    when "twitter"
      begin
        client = current_user.twitter_client
        client.update(@body)
        status = :success
        message = I18n.t("questions.show.share_success", :site => "Twitter")
        track_event(:shared_question, :where => "twitter")
      end
    end

    respond_to do |format|
      format.html do
        redirect_to question_path(@question)
      end

      format.js do
        case status
        when :success
          render :json => {
            :success => true,
            :message => message
          }.to_json
        when :needs_permission
          render :json => {
            :success => false,
            :status => "needs_permission",
            :html => (render_cell :external_accounts, :needs_permission,
                      :provider => params[:where])
          }.to_json
        end
      end
    end
  end

  # Check whether the corresponding external account is actually present,
  # asking the user to connect it if it isn't.
  def check_connections
    status = :success

    case params[:where]
    when "facebook"
      if !current_user.facebook_account
        status = :needs_connection
      end
    when "twitter"
      status = :needs_connection if !current_user.twitter_client
    else
      status = :unknown_destination
    end

    if status != :success
      respond_to do |format|
        format.js do
          case status
          when :needs_connection
            session["omniauth_return_url"] =
              question_url(Question.find_by_id(params[:question]))
            render :json => {
              :success => false,
              :status => "needs_connection",
              :html => (render_cell :external_accounts, :needs_connection,
                        :provider => params[:where])
            }.to_json
          when :unknown_destination
            render :json => {
              :success => false,
              :message => I18n.t("questions.show.unknown_destination")
            }.to_json
          end
        end
      end
    end
  end

end
