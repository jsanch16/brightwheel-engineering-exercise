# found in lib/
require 'sendgrid_mailer'
require 'mailgun_mailer'
class Api::V1::EmailsController < ApplicationController
  before_action :set_mailer, only: :send_email

  def send_email
    result = @mailer.new(
      email_params[:from],
      email_params[:to],
      email_params[:subject],
      email_params[:content]
    ).call
    render json: {message: result.message}, status: result.code
  end

  private

  # Enforces the required parameters to be present in the request
  def email_params
    params.require([:from, :to, :subject, :content])
    params.permit(:from, :to, :subject, :content)
  end

  # Set mailer to use based on MAILER_API environment variable
  def set_mailer
    mailers_hash = { 'sendgrid' => SendGridMailer, 'mailgun' => MailGunMailer }
    @mailer = mailers_hash[ENV['MAILER_API']] || SendGridMailer
  end
end
