# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
require 'faker'

# Crear 10 usuarios aleatorios
10.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8),
    role: ['admin', 'normal'].sample # Rol al azar entre admin y normal
  )
end

# Obtener IDs de los usuarios creados
users = User.pluck(:id)

# Crear 10 posts aleatorios, cada uno asociado a un usuario al azar
10.times do
  Post.create!(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraph(sentence_count: 5),
    user_id: users.sample # Asignar post a un usuario aleatorio
  )
end

# Obtener IDs de los posts creados
posts = Post.pluck(:id)

# Crear 50 comentarios, cada uno asociado a un usuario y a un post aleatorio
50.times do
  Comment.create!(
    body: Faker::Lorem.sentence(word_count: 10), # Comentario de 10 palabras
    user_id: users.sample,  # Asignar comentario a un usuario aleatorio
    post_id: posts.sample   # Asignar comentario a un post aleatorio
  )
end

puts "Se han creado 10 usuarios, 10 posts y 50 comentarios aleatorios."
