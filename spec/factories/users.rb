FactoryBot.define do
  factory :user do
    email { 'test@test.ts' }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
