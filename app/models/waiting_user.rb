class WaitingUser
  include MongoMapper::Document

  key :_id, String
  key :email, String
  key :university, String
  key :confirmation_token, String, :index => true

  timestamps!

  validates_presence_of   :email
  validates_uniqueness_of :email
  after_create            :send_wait_note

  def non_academic_email?
    self.email =~ /\.com(\.|$)/
  end

  def send_wait_note
    if non_academic_email?
      Notifier.non_academic(self).deliver
    else
      Notifier.wait(self).deliver
    end
  end

  def self.resend_wait_note(email)
    where(:email=>email).first.send_wait_note
  end
end
