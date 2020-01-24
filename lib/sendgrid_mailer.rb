require 'mailer'

class SendGridMailer < Mailer
  def call
    headers = {
      "Authorization" => "Bearer #{api_key}",
      "Content-Type" => 'application/json'
    }
    data = {
      personalizations: [
        {
          to: [
            {
              email: to
            }
          ],
          subject: subject
        }
      ],
      from: {
        email: from
      },
      content: [
        {
          type: "text/plain",
          value: content
        }
      ]
    }
    begin
      response = RestClient.post(
        "#{base_url}/mail/send",
        data.to_json,
        headers
      )
      MailerResponse.new(true, 'Email successfully sent', response.code)
    rescue RestClient::ExceptionWithResponse => e
      MailerResponse.new(
        false, 'There was a problem sending the email', e.response.code
      )
    end
  end

  private

  def base_url
    "https://api.sendgrid.com/v3"
  end

  def api_key
    ENV['SENDGRID_API_KEY']
  end
end