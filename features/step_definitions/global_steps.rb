Дано('Пользователь открыл главную') do
  visit root_path
end

То /^Я должен видеть кнопку с текстом "(.*?)" и id (.+)$/ do |text, btn_id|
  page.document.synchronize(1) do
    page.should have_css "##{btn_id}", text: text
  end
end

Когда /^Я кликнул по кнопке с id (.+)$/ do |btn_id|
  find("##{btn_id}").click
end

Когда /^Я залогинился как пользователь$/ do
  visit '/users/sign_in'
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  find('input[type="submit"]').click # click_button "Log In"
end

То /^Я должен видеть кнопку с текстом "(.*?)" и с классом (.+)$/ do |text, klass|
  sleep 0.5
  page.should have_css ".#{klass}", text: text
end