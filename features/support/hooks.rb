Capybara.app_host = 'http://google.com.ua'
Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.save_and_open_page_path = 'screenshot'
