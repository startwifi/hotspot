execute "sudo echo '' > /etc/default/ufw-chef.rules"

firewall 'ufw' do
  action :install
end

firewall_rule 'http' do
  port 80
  protocol :tcp
  action :create
end

firewall_rule 'https' do
  port 443
  protocol :tcp
  action :create
end
