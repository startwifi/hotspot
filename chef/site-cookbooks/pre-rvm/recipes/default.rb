execute 'download RVM GPG key' do
  user 'deploy'
  environment 'HOME' => '/home/deploy'
  command 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
end
