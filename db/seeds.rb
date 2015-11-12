def copy_image_fixture(file_name, id)
  dir = Rails.root.join('public', 'uploads')
  Dir.mkdir(dir) unless File.directory?(dir)
  FileUtils.cp(file_name, dir.join(id.to_s))
end

medi_category = Category.create(name: 'Meditation book')
fashion_category = Category.create(name: 'Fashion book')
it_category = Category.create(name: 'IT Book')
cooking_category = Category.create(name: 'Cooking book')
fixtures_category = Category.create(name: 'Fixtures')

fixtures_path = Rails.root.join('app', 'assets', 'images', 'fixtures')

cpu = Product.create(title: 'Yoga for everyone', price: 300, description: 'Yoga for everyone', category: medi_category)
copy_image_fixture(fixtures_path.join('medi.jpg'), cpu.id)

ram = Product.create(title: 'Hacking internet', price: 40, description: 'Hacking internet' , category: it_category)
copy_image_fixture(fixtures_path.join('hack.jpg'), ram.id)

hdd = Product.create(title: 'cooking egg', price: 60, description: 'cooking egg', category: cooking_category)
copy_image_fixture(fixtures_path.join('egg.jpg'), hdd.id)

mb = Product.create(title: 'spring fashion', price: 120, description: 'spring fashion' , category: fashion_category)
copy_image_fixture(fixtures_path.join('spring.jpg'), mb.id)

50.times do
  Product.create(title: 'Meditation', price: 300, description: 'Meditation', category: medi_category)
copy_image_fixture(fixtures_path.join('medi.jpg'), cpu.id)
end

50.times do
  Product.create(title: 'Fashion book', price: 300, description: 'Fashion book', category: fashion_category)
copy_image_fixture(fixtures_path.join('spring.jpg'), cpu.id)
end

user = User.create(name: 'Linh', email: 'linh@user.com', password: '12345678', password_confirmation: '12345678')
admin_user = User.create(name: 'nctruong', email: 'nctruong@admin.com', password: '12345678', password_confirmation: '12345678', admin: true)