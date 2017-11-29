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
  has_many :items, dependent: :destroy

  def date_range( start_date, end_date )
    # items.find_all { |i| i.in_range( start_date, end_date ) }
    if start_date.nil? && end_date.nil? then
      items.order( :trx_date)
    elsif !start_date.nil? && !end_date.nil? then
      items.order( :trx_date).where( trx_date: start_date..end_date )
    elsif !start_date.nil? then
      items.order( :trx_date).where( 'trx_date >= ?', start_date )
    else
      items.order( :trx_date).where( 'trx_date <= ?', end_date )
    end
  end

  # balance over a date range of items
  def balance( range)
    range.reduce( 0.0 ) { |s,i| s + i.signed_amount } 
  end

	def running_balance( range )
    s = 0
		range.map { |i| 
      s = s + i.signed_amount
      { item: i, balance: s }
    }
  end

  # first item/date on which balance <= limit, or nil
  def threshold( item_set, limit = 0)
    balance = 0
    item = nil

    item_set.order( :trx_date).each { |i|
      balance = balance + i.signed_amount

      if balance <= limit then
        item = i
	      break
      end
    }

    item.nil? ? "none" : item
  end

  def min_date
    Date.new( year, 1, 1)
  end

  def max_date
    Date.new( year, 12, 31)
  end
end
