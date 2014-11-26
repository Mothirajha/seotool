# https://raw.githubusercontent.com/defunkt/unicorn/master/examples/unicorn.conf.rb
app_path = "/home/deployer/apps/seotool/current"
 
worker_processes   2
preload_app        true
timeout            30
listen             8080, :tcp_nopush => true
working_directory  app_path
unless Dir[app_path+"/tmp/pids"].present?
	`mkdir /home/deployer/apps/seotool/current/tmp/pids`
end
pid                "#{app_path}/tmp/pids/unicorn.pid"
stderr_path        "#{app_path}/log/unicorn.log"
stdout_path        "#{app_path}/log/unicorn.log"
 
before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!
 
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
 
after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end