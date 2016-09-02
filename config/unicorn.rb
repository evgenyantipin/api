#unicorn.rb
worker_processes 1

preload_app true
timeout 30

application_name ='reactapi'
socket_name = application_name

deploy_dir = "/var/www/#{application_name}"

listen "/var/www/#{application_name}/shared/tmp/sockets/unicorn.sock", :backlog => 1024

working_directory "#{deploy_dir}/current/"
pid               "#{deploy_dir}/shared/pids/unicorn.pid"
stderr_path       "#{deploy_dir}/shared/log/unicorn.stderr.log"
stdout_path       "#{deploy_dir}/shared/log/unicorn.stdout.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end
