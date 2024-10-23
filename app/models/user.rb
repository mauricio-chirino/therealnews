# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string
#
class User < ApplicationRecord
  # Relación: Un usuario puede tener muchos posts y muchos comentarios
  has_many :posts
  has_many :comments
  # Devise: Para autenticación
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # Rol de administrador
  def admin?
    self.role == 'admin'
  end
end
