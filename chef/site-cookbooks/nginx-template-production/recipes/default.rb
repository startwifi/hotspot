template "#{node.nginx.dir}/sites-available/hotspot.conf" do
  source 'hotspot.conf.erb'
  mode '0644'
  notifies :reload, 'service[nginx]', :delayed
end

nginx_site 'hotspot.conf'
