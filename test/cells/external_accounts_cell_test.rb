require 'test_helper'

class ExternalAccountsCellTest < Cell::TestCase
  test "display" do
    invoke :display
    assert_select "p"
  end
  

end
