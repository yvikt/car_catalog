# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# переходим в папку public
Dir.chdir 'public'

# создаем массив путей у файлам
images = Dir['cars/*']

# сеем-сеем-посеваем - создаем для каждой картинки модель
# и инициализируем поле img_url ардесом картинки
images.each do |image|
 Vehicle.create img_url: image
end