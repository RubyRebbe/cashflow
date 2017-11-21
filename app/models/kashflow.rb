# == Schema Information
#
# Table name: kashflows
#
#  id         :integer          not null, primary key
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Kashflow < ApplicationRecord
	has_many :items
end
