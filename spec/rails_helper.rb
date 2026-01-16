require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
# Uncomment the line below in case you have `--require rails_helper` in the `.rspec` file
# that will avoid rails generators crashing because migrations haven't been run yet
return unless Rails.env.test?
require 'rspec/rails'

Capybara.register_driver :chrome do |app|
      driver = Capybara::Selenium::Driver.new(app, browser: :chrome, options: chrome_options )
      headless_download_setup(driver)
      driver
end

def chrome_options
  opts = Selenium::WebDriver::Chrome::Options.new
  opts.add_argument('--headless') unless ENV['UI']
  opts.add_argument('--no-sandbox')
  opts.add_argument('--disable-gpu')
  opts.add_argument('--disable-dev-shm-usage')
  opts.add_argument('--window-size=1400,1400')

  opts.add_preference(:browser, set_download_behavior: { behavior: 'allow' })
  opts
end

def headless_download_setup(driver)
  bridge = driver.browser.send(:bridge)

  path = '/session/:session_id/chromium/send_command'
  path[':session_id'] = bridge.session_id

  bridge.http.call(:post, path, cmd: 'Page.setDownloadBehavior',
                   params: {
                       behavior: 'allow',
                       downloadPath: '/tmp/'
                   })
  driver
end

Capybara.current_driver = :chrome
Capybara.javascript_driver = :chrome

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.after(:each, type: :system) do |example|
    if example.exception && example.metadata[:type]
      tmp = 'spec/support/screenshots/'
      spec_error_filename = example.location.split('/').last.sub(":","-")
      screenshot_path = Rails.root.join(
        "#{tmp + spec_error_filename}_#{Time.current.strftime("%H-%M")}.png"
      )
      page.save_screenshot(screenshot_path)
    end
  end

  config.filter_rails_from_backtrace!
end
