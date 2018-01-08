# == Schema Information
#
# Table name: items
#
#  id                :integer          not null, primary key
#  trx_type          :string
#  trx_date          :date
#  amount            :float
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  kashflow_id       :integer
#  recurrent_item_id :integer
#

class Item < ApplicationRecord
  belongs_to :kashflow
  belongs_to :recurrent_item, optional: true

	# volatile attribute, non-persistent
  attr_accessor :balance, :recurrence

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

  def to_s
    "#{trx_type} | #{trx_date} | #{amount} | #{name}"
  end

  # html helper
	def to_row
    [
	    trx_type,
      trx_date,
			"%.2f" % amount,
		  name
		].reduce( "" ) { |s,e| s + "\n" + td( e ) }.html_safe
  end

  def td( s, options = "" )
	  "<td #{options}>  #{s} </td>"
  end

	def tr
		( '<tr style="color:' + color + '">' ).html_safe
  end

	def colored_balance
			b = "%.2f" % balance
			color = ( balance > 0 ) ? "green" : "red"
			td( b, 'style="color:' + color  + '"' ).html_safe
  end

	def color
		if trx_type == "expense" then
		  "red"
		else
		  "green"
    end
  end

	def recurrent?
		!recurrent_item.blank?
  end
end
