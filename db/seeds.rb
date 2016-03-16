# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

## HotSpot Init Structure
#

# Root Admin

root = Admin.new

root.email = 'root@acme.com'
root.password = 'hotspot3'
root.password_confirmation = 'hotspot3'
root.admin = true # Wierd Tricky
root.save!

# Regular Admin with Company

admin = Admin.new

admin.email = 'admin@acme.com'
admin.password = 'hotspot34'
admin.password_confirmation = 'hotspot34'

company = Company.create do |c|
  c.name =    'Acme Inc.'
  c.phone =   '+0001113322'
  c.address = 'Unavaible'
  c.owner_name = "HotSpot"
end

# Some basic seed what we need from ENV
company_group = company.name.parameterize
ENV['FB_GROUP_NAME'] = company_group
ENV['VK_GROUP_NAME'] = company_group
ENV['TW_GROUP_NAME'] = company_group
ENV['IN_GROUP_NAME'] = company_group
ENV['OK_GROUP_NAME'] = company_group

company.create_dummy_social(:tw, :in, :ok)

company.create_fb! do |fb|
  fb.group_id = '1233145112'
  fb.group_name = ENV['FB_GROUP_NAME']
  fb.action = 'disabled'
  fb.link_redirect = ENV['LINK_REDIRECT']
  fb.post_text = company.name,
  fb.post_link = company.get_group_link(:fb),
  fb.post_image = Rails.root.join('app/assets/images/startwifi.png').open
end

company.create_vk! do |fb|
  fb.group_id = '1233145112'
  fb.group_name = ENV['VK_GROUP_NAME']
  fb.action = 'disabled'
  fb.link_redirect = ENV['LINK_REDIRECT']
  fb.post_text = company.name,
  fb.post_link = company.get_group_link(:vk),
  fb.post_image = Rails.root.join('app/assets/images/startwifi.png').open
end

admin.company = company
admin.save!

puts '******************'
puts
puts 'Auth URL:'
puts "http://localhost:3000/auth?hs[token]=#{company.token}}"
puts
puts '******************'
