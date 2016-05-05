require 'capybara'

module GoogleSearch
  def search
    visit '/'
    fill_in 'lst-ib', with: 'Ruby'
    sleep 2
    find('#sblsbb button').click
    sleep 2
  end
end
