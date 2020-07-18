#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.destroy_all
User.destroy_all
UserRole.destroy_all
Permission.destroy_all


5.times do |i|
  Role.create(name: "Role ##{i}", description: "This is description #{i}")
end

role_admin = Role.create!(
  name: "Admin",
  description: "This is description"
)

admin = User.create!(
  name: "Admin",
  email: "admin@hvktqs.com",
  password: 123456
)

user_role = UserRole.create!(
  user_id: admin.id,
  role_id: role_admin.id
)

permission = Permission.create!(
  role_id: role_admin.id,
  authorization_id: 9999
) 