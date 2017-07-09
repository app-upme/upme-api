# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@upme.com', password: 'secret')

coach = Coach.create(email: 'treinador@upme.com', password: 'secret', name: 'Treinador 1')
group = Group.create(coach: coach, name: 'Turma de futsal sub15', description: 'obs: quadra coberta toda quarta e sexta')
user  = User.create(group: group, name: 'Nicolas Lima', age: 22, gender: :male, started_training_at: Date.today, email: 'nicolas@upme.com')
Vo2maxTraining.create(user: user, distance: 2200, training_date: Date.today)
