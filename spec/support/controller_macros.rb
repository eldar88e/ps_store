module ControllerMacros
  def login_user(user=nil)
    before do
      sign_in user || FactoryBot.create(:user)
    end
  end
end
