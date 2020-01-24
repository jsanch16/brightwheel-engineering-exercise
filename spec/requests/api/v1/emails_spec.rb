require 'rails_helper'

RSpec.describe "Api::V1::Emails", type: :request do
  describe "POST /api/v1/email" do
    let(:url) { '/api/email' }
    let(:to) { 'test@example.com' }
    let(:from) { 'test@example.com' }
    let(:subject) { 'Test Subject' }
    let(:content) { '<h1>This is a test email.</h1>' }
    let(:valid_attributes) {
      { from: from, to: to, subject: subject, content: content}
    }
    context "when correct email data is provided" do
      before do
        stub_request(:post, "https://api.sendgrid.com/v3/mail/send")
          .to_return(status: 202)
        post url, params: valid_attributes, headers: v1_header
      end

      it "returns status code 200" do
        expect(response).to have_http_status(202)
      end

      it "returns success message" do
        expect(json[:message]).to eq("Email successfully sent")
      end
    end

    context "with missing required parameters" do
      let(:invalid_attributes){
        { from: from, subject: subject, content: content}
      }
      before { post(url, params: invalid_attributes, headers: v1_header) }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it 'returns missing parameter error' do
        expect(json[:message]).to eq(
          'param is missing or the value is empty: to'
        )
      end
    end

    context 'when the email fails to send' do
      before do
        stub_request(:post, "https://api.sendgrid.com/v3/mail/send")
          .to_return(status: 400)
        post url, params: valid_attributes, headers: v1_header
      end

      it "return status code 422" do
        expect(response).to have_http_status(400)
      end

      it "returns with error message of emailing sending failure" do
        expect(json[:message]).to eq('There was a problem sending the email')
      end
    end

    context "when mailer api environment variable is changed to 'mailgun'" do
      before do
        ENV["MAILER_API"] = 'mailgun'
        stub_request(
          :post,
          'https://api.mailgun.net/v3/sandboxad941c3712cd4447b942c0388cf4f8c3.'\
          'mailgun.org/messages'
        ).to_return(status: 200)
        post url, params: valid_attributes, headers: v1_header
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end

      it "returns success message" do
        expect(json[:message]).to eq("Email successfully sent")
      end
    end

    context "when mailgun email fails to send" do
      before do
        ENV["MAILER_API"] = 'mailgun'
        stub_request(
          :post,
          'https://api.mailgun.net/v3/sandboxad941c3712cd4447b942c0388cf4f8c3.'\
          'mailgun.org/messages'
        ).to_return(status: 400)
        post url, params: valid_attributes, headers: v1_header
      end

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end

      it "returns success message" do
        expect(json[:message]).to eq("There was a problem sending the email")
      end
    end
  end
end
