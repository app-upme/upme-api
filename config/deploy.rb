require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :repository, 'git@bitbucket.org:jerasoftware/autonomos_api.git'
set :shared_paths, ['config/database.yml', 'log', 'public/system', 'tmp/pids', 'tmp/sockets', 'config/application.yml']

# set :identity_file, ENV['IDENTIFY_FILE']
set :environment,   ENV['ENV']

set :term_mode, true
set :rvm_path, "/usr/local/rvm/scripts/rvm"
set :force_assets, true

if environment == 'production'
  set :user, 'autonomos'
  set :domain, 'loki.jera.com.br'
  set :ruby_version,  'ruby-2.3.0'
  set :deploy_to, '/var/www/autonomos/production'
  set :branch,    'master'
  set :gemset,    'autonomos_production'
  set :rails_env, 'production'
elsif environment == 'staging'
  set :user, 'autonomos'
  set :domain, 'hel.jera.com.br'
  set :ruby_version,  'ruby-2.3.0'
  set :deploy_to, '/var/www/autonomos/staging'
  set :branch,    'develop'
  set :gemset,    'autonomos_staging'
  set :rails_env, 'staging'
end


### ROLLBAR CONFIG ###

set :git_hash, `git log -n 1 --pretty=format:\"%H\"`
set :dev_user, `git config user.name`
set :rollbar_url, "https://api.rollbar.com/api/1/deploy/"
set :rollbar_token, "5e0271e13c6e4b5aba4d829732372d88"

task notify_rollbar: :environment do
  command =  "curl #{rollbar_url} -F access_token='#{rollbar_token}' -F environment=#{rails_env} -F revision='#{git_hash}' -F  local_username='#{dev_user}'"
  queue "echo 'notify rollbar revision #{git_hash}'"
  queue command
end

###

task :environment do
  if !environment
    abort "You need to pass the identify file and environment, ex. mina deploy ENV=[production,staging] IDENTIFY_FILE=$HOME/ec2/key.pem"
  end
    invoke :"rvm:use[#{ruby_version}@#{gemset}]"
end

task restart: :environment do
  pidfile = "#{deploy_to}/current/tmp/pids/unicorn.pid"
  queue "if [ -f #{pidfile} ]; then kill -s USR2 `cat #{pidfile}`;fi"
end

task setup: :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "Be sure to edit 'shared/config/database.yml'."]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]

  queue! %[mkdir -p "#{deploy_to}/shared/public/system"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/system"]
end

desc "Deploys the current version to the server."
task deploy: :environment do
  # deploy do
  #   invoke :'git:clone'
  #   invoke :'deploy:link_shared_paths'
  #   queue  %[#{bundle_bin} install --without development test]
  #   invoke :"rvm:wrapper[#{ruby_version}@#{gemset}, #{gemset} ,unicorn_rails]"
  #   invoke :'rails:db_migrate'
  #   invoke :'rails:assets_precompile'
  #   invoke :'deploy:cleanup'
  #   # queue %[#{bundle_bin} exec rake squash:notify DEPLOY_ENV=#{rails_env} REVISION=#{last_commit} RAILS_ENV=#{rails_env}]
  #   # queue %[echo #{last_commit} > revision]
  #   # queue %[#{bundle_bin} exec rake tmp:cache:clear]

  #   to :launch do
  #     queue "ln -s /var/www/#{user}/front/#{rails_env}/current/dist #{deploy_to}/#{current_path}/public/front"
  #     invoke :restart
  #   end

  # end
end

desc "test rollbar"
task :test_deploy do
  invoke :notify_rollbar
end
