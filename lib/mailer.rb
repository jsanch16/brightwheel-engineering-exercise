class Mailer
  attr_accessor :from, :to, :subject, :content

  MailerResponse = Struct.new(:success?, :message, :code)

  # @param from_email [String] email address 
  # @param to_email [String] email address 
  # @param subject_str [String]
  # @param content_str [String]
  # @return [Struct]
  def initialize(from, to, subject, content)
    @from = from
    @to = to
    @subject = subject
    @content = strip_html_tags(content)
  end

  # mandatory: define a #call method. its return value will be available
  #            through #result
  # @return response [MailerResponse] structure containing message or errors
  def call
    raise "Not Implemented"
  end

  private

  def strip_html_tags(str)
    ActionController::Base.helpers.strip_tags(str)
  end
end