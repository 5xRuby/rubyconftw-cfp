require 'test_helper'

class PapersMailerTest < ActionMailer::TestCase
  test "sent_cfp_email" do
    mail = PapersMailer.sent_cfp_email
    assert_equal "Sent cfp email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
