FactoryBot.define do
  factory :game do
    name { 'The Last of Us Part II Remastered' }
    price { 5620 }
    content { '«Предзаказ - Требует немедленной оплаты»' }
    platform { 'PS5' }
    genre { 'Action, Adventure' }
    rus_voice { true }
    rus_screen { true }
    nps_id { 'EP9000-PPSA15508_00-THELASTOFUSPART2' }
  end
end
