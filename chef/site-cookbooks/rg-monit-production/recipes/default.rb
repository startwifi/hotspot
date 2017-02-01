cookbook_file "/etc/monit/conf.d/nginx.conf" do
  user "root"
  group "root"
  mode "0644"
end

cookbook_file "/etc/monit/conf.d/puma.conf" do
  user "root"
  group "root"
  mode "0644"
end

# cookbook_file "/etc/monit/conf.d/newrelic.conf" do
#   user "root"
#   group "root"
#   mode "0655"
# end

execute 'sudo monit reload'
execute 'sudo monit start all'
