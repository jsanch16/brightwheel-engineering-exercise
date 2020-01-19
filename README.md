Juan Sanchez Brightwheel Platform Engineering Assignment:


* Steps to install and run application:
  1. Run `bundle install` to install rails gem dependencies
  2. Run `rails db:create` and `rails db:migrate` to create sqlite dbs
  3. Run `rails db:create RAILS_ENV=test` and `rails db:migrate RAILS_ENV=test` to create sqlite test dbs
  4. Run `rails server` to boot up rails server (usually runs on localhost:3000)

Steps to run tests
  1. From rails project root run `rspec spec/`

Steps to hit endpoints with Curl
  1. Make sure `rails server` is running
  2. To test the create:
    a. run in terminal `curl -d '{"extension":".txt", "description":"Test description", "tags":"tag1,tag2,tag3"}' -H "Content-type: application/json" -X POST http://localhost:3000/api/data`
  3. To test the PUT:
    a. run in terminal `curl -X PUT -F "file=@/path/to/local_file.txt" http://localhost:3000/api/data/{id of newly created data}`
  4. To test the GET:
    a. run in terminal `curl -X GET http://localhost:3000/api/data/{id}`

Tech stack and framework decisions:
  I went with Ruby on Rails for this assignment because I have the strongest epxerience with it and it highly lends itself for applications that you want to get up and running as fast as possible. 

Phase 1:

  I found it easier to use a single-table design for this project. The first endoint is designed to be a regular POST
  endpoint where the user submits desired extension and other file metadata as parameters. This `Data` table I made
  essentially stores the id and a string format of the json 'state' of the file metadata submitted in the parameters.

Phase 2:

  For this endpoint I thought it was best to do a PUT to the created `Data` record. Ideally this endpoint would be hit with multipart-form
  data where the user specifies on the frontend the filepath of the file to 'upload'. I then put the filesize and filename from the file
  and merge it into the parsed JSON `state` column that I have for the file metadata.

Get Endpoint:

  This behaves like your standard GET endpoint. The user receives the id from the previous POST and PUT to GET the state_data. I'm
  essentially returning the `state` text column of `Data` into a JSON parsed object.


Supplemental Questions:

  a. How do you typically manage dependencies for a project?

    For a Rails proejct there are alot of resources to help keep your dependencies in check
    on a per project basis:

      1. RVM (Ruby Version Manager) allows you to maintain multiple ruby versions which is
        helpful when you have many projects with differing ruby versions.
      2. Bundler allows you keep all your Rails gems and their respective versions in a single
        "Gemfile" and allows you install all the dependencies of a Rails project with a simple
        `bundle install` command.

          a. My general approach is make sure I explicilty specify the version of every gem in my Gemfile.
            If not, you run into a frustrating problem when if you reinstall your gems or accidently update them,
            the gems may update with some breaking changes to your code.

  b. Provide a top 3 of your favorite resources (blogs, books, people, etc...) that you
    use to improve as an engineer. Please explain why you like that particular
    resource.

    1. https://thoughtbot.com/blog
      Thoughtbot is a consulting company that are considered one the gold standards in the
      Rails community as far as coding conventions and general consulting goes. Their engineers also
      make alot of gems that I use in my projects, FactoryBot being an example. Their blog is especially
      useful because their engineers post daily about specific ways to make your code cleaner or new tools
      to help streamline your rails development process.
    2. "Clean Code" by Robert C. Martin
      This is a popular book amongst programmers. I liked it because it helped me in one of the main areas I
      think my college professors neglected when I was in school, which was writing readable, maintable code. 
    3. Stack Overflow:
      This is an obvious one. It's my go-to source when I run into a bug that isn't inherently obvious where the
      issue is. They also helpful in general algorithm advice for any programming language or framework you write
      in.

  c. How would you test a piece of code that requires access to a remote database
    through a network connection?

      Ideally you don't want your unit tests to actaully hit any external endpoints as it will both
      slow down your tests and make your tests dependent on an external source functioning correctly
      at all times. The best thing to do is use Mocking in these scenarios. Essentially you would mock
      the method that makes the actual API call to make it simulate and return the expected result,
      that way the rest of the code your unit test is testing can continue with the data that it
      needs from the external source. 


* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Rspec for testing with database cleaner
rack-attack for rate throttling
