# frozen_string_literal: true

# Helper for feature tests
module SpecMacros
  def log_in_user(email, password)
    visit root_path
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    click_on 'Log in'
  end

  def check_presence(content)
    content.each { |element| expect(page).to have_content element }
  end

  def check_absence(content)
    content.each { |element| expect(page).to_not have_content element }
  end

  def check_links(content)
    content.each { |element| expect(page).to have_link element }
  end

  def click(elements)
    elements.each { |element| click_on element }
  end
end
