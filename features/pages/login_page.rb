require 'capybara'

module GoogleSearch
  def search
    visit '/webhp'
    fill_in 'lst-ib', with: 'Ruby'
    sleep 2
    find('#sblsbb button').click
    sleep 2
    puts 'clicked on google button'
  end
end
