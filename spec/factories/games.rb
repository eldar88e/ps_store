FactoryBot.define do
  factory :game do
    name { 'The Last of Us Part II Remastered' }
    price { 5620 }
    content { '«Предзаказ - Требует немедленной оплаты»' }
    img { "https://store.playstation.com/store/api/chihiro/00_09_000/container/TR/tr/99/EP9000-PPSA15508_00-THELASTOFUSPART2/0/image?_version=00_09_000&platform=chihiro&bg_color=000000&opacity=100&w=586&h=586" }
    platform { 'PS5' }
    genre { 'Action, Adventure' }
    rus_voice { true }
    rus_screen { true }
    nps_id { 'EP9000-PPSA15508_00-THELASTOFUSPART2' }
  end
end
