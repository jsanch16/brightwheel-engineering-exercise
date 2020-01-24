require 'mailer'

class MailGunMailer < Mailer
  def call
    data = {
      from: from,
      to: to,
      subject: subject,
      text: content
    }
    begin
      response = RestClient.post(
        "#{base_url}/sandboxad941c3712cd4447b942c0388cf4f8c3.mailgun.org/messages",
        data
      )
      MailerResponse.new(true, 'Email successfully sent', response.code)
    rescue RestClient::BadRequest => e
      MailerResponse.new(
        false, 'There was a problem sending the email', e.response.code
      )
    end
  end

  private

  def base_url
    "https://api:#{api_key}@api.mailgun.net/v3"
  end

  def api_key
    ENV['MAILGUN_API_KEY']
  end
end