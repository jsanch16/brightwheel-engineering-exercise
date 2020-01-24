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
    a. Change the `MAILER_API` environment variable to 'mailgun' by:
      1. Either running `export MAILER_API="mailgun"` in your terminal to add the new environment variable.
      2. Shut down the rails server, modify MAILER_API in config/local_env.yml in this project to `mailgun`, and restart the rails server.
    b. run in terminal `curl -d '{"from":"<email@address.com>", "to":"<jsanch165@gmail.com>", "subject":"Test Subject", "content": "<h1>Hello there.</h1>"}' -H "Content-type: application/json" -H "Accept: application/api.brightwheel.v1" -X POST http://localhost:3000/api/email`
    c. (NOTE): mailgun only allows to send emails to `verified accounts` unless you get a domain which I believe is out of the scope of this assignment. So for testing purposes, the recipient can only be my email address: jsanch165@gmail.com

* Tech stack and framework decisions:
  1. I went with Ruby on Rails for this assignment because I have the strongest epxerience with it and it highly lends itself for applications that you want to get up and running as fast as possible.
  2. I implemented API versioning with a version header for backwards compatability. It defaults to V1 if no version header is provided.
  3. I used Rspec for writing my unit and integration/request testing.
  4. I used Webmock to mock the external API calls in my request tests.
  5. I used RestClient to hit the Sendgrid and Mailgun endpoints.
  6. I made a local_env.yml that essentially gets run at server bootup that sets the environment variables needed.


* Things to add or refactor if given more time:
  1. Improve error handling to show more detailed errors.
  2. Email address validation, same generic error is shown if email address is invalid.
  3. Write more unit tests for the emailing service objects, right not they're only indirectly tested through my integration/request tests.
  4. Implement User and JWT token based authentication to authenticate the user attempting to hit the endpoint.