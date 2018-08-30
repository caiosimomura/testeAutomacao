require 'capybara/cucumber'
require 'selenium-webdriver'
require 'rspec'
require 'openssl'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
require 'faker'

Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
  
Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 15