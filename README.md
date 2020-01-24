Juan Sanchez Brightwheel Platform Engineering Assignment:


* Steps to install and run application:
  1. Run `bundle install` to install rails gem dependencies
  2. Run `rails server` to boot up rails server (usually runs on localhost:3000)

* I've included some request tests and a few unit tests to test the endpoint. The steps to run tests:
  1. From rails project root run `rspec spec/`

* Steps to send emails manually with Curl
  1. Make sure `rails server` is running
  2. To test sending an email with sendgrid (default):
    a. run in terminal `curl -d '{"from":"<email@address.com>", "to":"<email@address.com>", "subject":"Test Subject", "content": "<h1>Hello there.</h1>"}' -H "Content-type: application/json" -H "Accept: application/api.brightwheel.v1" -X POST http://localhost:3000/api/email`
  3. To test sending an email with mailgun:
    a. Either `export MAILER_API="mailgun"` in your terminal to add the new environment variable or modify MAILER_API in config/local_env.yml in this project to `mailgun`.
    b. run in terminal `curl -d '{"from":"<email@address.com>", "to":"<jsanch165@gmail.com>", "subject":"Test Subject", "content": "<h1>Hello there.</h1>"}' -H "Content-type: application/json" -H "Accept: application/api.brightwheel.v1" -X POST http://localhost:3000/api/email`
    c. (NOTE): mailgun only allows to send emails to `verified accounts` unless you get a domain which I believe is out of the scope of this assignment. So for testing purposes, the recipient can only be my email address: jsanch165@gmail.com

* Tech stack and framework decisions:
  -I went with Ruby on Rails for this assignment because I have the strongest epxerience with it and it highly lends itself for applications that you want to get up and running as fast as possible.
  -I implemented API versioning with a version header for backwards compatability. It defaults to V1 if no version header is provided.
  -I used Rspec for writing my unit and integration/request testing.
  -I used Webmock to mock the external API calls in my request tests.
  -I used RestClient to hit the Sendgrid and Mailgun endpoints.


* Things to add or refactor if given more time:
  -Improve error handling to show more detailed errors.
  -Email address validation, same generic error is shown if email address is invalid.
  -Write more unit tests for the emailing service objects, right not they're only indirectly tested through my integration/request tests.
  -Implement User and JWT token based authentication to authenticate the user attempting to hit the endpoint.