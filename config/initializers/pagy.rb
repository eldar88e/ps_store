require 'pagy/extras/bootstrap'
require 'pagy/extras/overflow'
require 'pagy/extras/i18n'

Pagy::DEFAULT[:overflow] = :empty_page # :last_page
Pagy::DEFAULT[:items] = 36 # items per page
Pagy::DEFAULT[:size]  = [1, 2, 2, 1]  # nav bar links
