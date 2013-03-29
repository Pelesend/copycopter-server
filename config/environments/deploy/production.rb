#role :app, 'corpapp01', 'corpapp02'
#role :web, 'corpapp01', 'corpapp02'

role :app, 'corpapp01'
role :web, 'corpapp01'
role :db,  'corpapp01', primary: true

set :branch, 'master'
set :user, 'copycpt1'
set :rvm_bin_path, '/usr/share/ruby-rvm/bin'