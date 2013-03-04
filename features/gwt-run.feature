Feature: compile gwt and start application with jetty

   Scenario: rails
     Given application with Gemfile.lock in "rails"
     Then jetty runs

     Given application without Gemfile.lock in "rails"
     Then jetty runs

   Scenario: rack application
     Given application with Gemfile.lock in "rack"
     Then jetty runs

