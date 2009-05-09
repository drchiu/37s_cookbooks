require_recipe "syslog"

directory node[:syslog_ng][:root] do
  owner "root"
  group "admin"
  mode 0755
end

template "/etc/syslog-ng/syslog-ng.conf" do
  source "syslog-ng-server.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "syslog-ng")
  variables(:applications => node[:applications])
end

if node[:applications]
  node[:applications].each do |app, config|
    directory node[:syslog_ng][:root] + "/#{app}" do
      owner "app"
      group "app"
      mode 0750
    end
  end
end

directory node[:syslog_ng][:root] + "syslog" do
  owner "root"
  group "app"
  mode 0750
end

logrotate "applications" do
  restart_command "/etc/init.d/syslog-ng reload 2>&1 || true"
  files node[:applications].keys.collect{|name| root+"/#{name}/*.log" }
  frequency "daily"
end

logrotate "syslog-remote" do
  restart_command "/etc/init.d/syslog-ng reload 2>&1 || true"
  files ['/u/logs/syslog/messages', "/u/logs/syslog/secure", "/u/logs/syslog/maillog", "/u/logs/syslog/cron"]
end


cron "old logs cleanup" do
  command "find /u/logs/basecamp -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \\;"
  hour "10"
  minute "0"
end

