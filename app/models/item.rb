# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  trx_type    :string
#  trx_date    :date
#  amount      :float
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  kashflow_id :integer
#

class Item < ApplicationRecord
	belongs_to :kashflow
end
