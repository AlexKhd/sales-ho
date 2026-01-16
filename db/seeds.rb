# db/seeds.rb

Option.where(optionid: 1).first_or_create!(title: 'DistId', value: 555, valuetxt: 'Head Office')
Face.where(fid: 555).first_or_create!(title: 'HO', dist_id: 555, ownerdist_id: 555, ftype: 20)

if User.count == 0
  admin = User.new(
    email: 'admin@example.com',
    password: 'admin321',
    password_confirmation: 'admin321',
    name: 'Admin',
    blocked: false
  )
  admin.skip_confirmation!
  admin.add_role :admin
  if admin.save
    #puts "Admin user created: email='admin@example.com', password='admin'"
  else
    puts "Failed to create admin user: #{admin.errors.full_messages.join(', ')}"
  end
end
