module ControllerMacros
  def login_user
    before do
      sign_in FactoryBot.create(:user)
    end
  end
end
