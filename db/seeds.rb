# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Tag.create([
  { name: 'PS5' },
  { name: 'Swich' },
  { name: 'PS4' },
  { name: '玩具' },
  { name: '周辺機' },
  ])
  
Admin.create!(
  email: 'star-game@admin.com',
  password: 'adminstar'
  )