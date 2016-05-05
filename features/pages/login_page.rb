require 'capybara'

module GoogleSearch
  def search
    fill_in 'lst-ib', with: 'Ruby'
    click_button 'btnK'
    sleep 10
  end
end
