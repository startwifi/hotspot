cookbook_file '/etc/ImageMagick/policy.xml' do
  source 'policy.xml'
  mode '0644'
  user 'root'
  action :create
end
