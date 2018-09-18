# == Schema Information
#
# Table name: users
#
#  created_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  id                     :bigint(8)        not null, primary key
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  updated_at             :datetime         not null
#  username               :string           default(""), not null
#
# Indexes
#
#  index_users_on_email                 (email)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  validates :first_name, :last_name, :email, :phone, :card, :encrypted_password, presence: true
  validates :email, uniqueness: true
  enum role: %i[user admin]
  validates :role, inclusion: { in: roles.keys }

  def self.role_options
    roles.map { |k, _v| [k.humanize.capitalize, k] }
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         password_length: 6..32
end
