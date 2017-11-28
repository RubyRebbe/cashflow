# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  email             :string
#  crypted_password  :string
#  password_salt     :string
#  persistence_token :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class User < ApplicationRecord
  validates :email, uniqueness: true

	acts_as_authentic
end
