shared_path = "/home/deployer/apps/seotool/shared"
root = "/home/deployer/apps/seotool/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{shared_path}/log/unicorn.log"
stdout_path "#{shared_path}/log/unicorn.log"

listen "/tmp/unicorn.seotool.sock"
worker_processes 2
timeout 30
