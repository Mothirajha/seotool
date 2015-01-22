app_path = "/home/deployer/apps/seotool/current"
shared_path = "/home/deployer/apps/seotool/shared"

worker_processes   2
preload_app        true
timeout            30
listen             "/tmp/unicorn.seotool.sock"
listen             8080, :tcp_nopush => true
working_directory  app_path

pid                "#{shared_path}/tmp/pids/unicorn.pid"
stderr_path        "#{shared_path}/log/unicorn.log"
stdout_path        "#{shared_path}/log/unicorn.log"
