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

	# volatile attribute, non-persistent
  attr_accessor :balance

  def in_range( start_date, end_date )
    a = (start_date == nil) ? true : ( start_date <= trx_date )
    b = (end_date == nil) ? true : ( trx_date <= end_date )

    a && b
  end

  def sign
    ( trx_type == "income" )  ? 1 : -1
  end

  def signed_amount
    sign*amount
  end

	def balance_color
    ( balance > 0 ) ? "green" : "red"
  end

  def to_s
    "#{trx_type} | #{trx_date} | #{amount} | #{name}"
  end
end
