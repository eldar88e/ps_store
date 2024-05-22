Дано('Пользователь открыл главную') do
  visit root_path
end

То /^Я должен видеть кнопку с текстом "(.*?)" и id (.+)$/ do |text, btn_id|
  page.document.synchronize(5) do
    page.should have_css "##{btn_id}", text: text
  end
end

Когда /^Я кликнул по кнопке с id (.+)$/ do |btn_id|
  page.document.synchronize(10) do
    find("##{btn_id}").click
  end
end

То /^Я должен видеть кнопку с текстом "(.*?)" и с классом (.+)$/ do |text, klass|
  page.document.synchronize(5) do
    page.should have_css ".#{klass}", text: text
  end
end

Когда /^Я залогинился как пользователь$/ do
  visit '/users/sign_in'
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  sleep 1
  binding.pry
  find('input[type="submit"]').click # click_button "Log In"
end