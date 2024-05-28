if true # Rails.env.development?
  games = CSV.read('./db/games.csv')
  games.shift

  games.each do |game|
    data                  = {}
    data[:name]           = game[2]
    data[:ps_id]          = nil
    data[:price]          = game[3]
    data[:old_price]      = game[4]
    data[:img]            = nil
    data[:genre]          = game[8]
    data[:content]        = game[9]
    data[:platform]       = game[10]
    data[:run_id]         = 1
    data[:touched_run_id] = 1
    data[:rus_screen]     = game[6] == 'Да'
    data[:rus_voice]      = game[7] == 'Да'
    data[:nps_id]         = game[5].split('/')[11]

    Game.create!(data)
  end

  AdminUser.create!(email: 'admin@example.com',
                    password: 'password',
                    password_confirmation: 'password') if Rails.env.development?

  User.create(email: 'test@test.tt', password: '12345678')

  puts 'The Developments tables is populated!'
end
