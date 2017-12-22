# == Schema Information
#
# Table name: recurrent_items
#
#  id         :integer          not null, primary key
#  start_date :date
#  end_date   :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecurrentItem < ApplicationRecord
  has_many :items, dependent: :destroy

  attr_accessor  :recurrence

  def valid_year?
		start_date.year == end_date.year
  end

	def dates_by_monthday
		d = start_date
    r = [ ]

		while d <= end_date do
      r << d
			d = d >> 1
    end

		r
  end

	def dates_by_weekday( weekday, nth )
		y =  start_date.year
		months = ( start_date.month..end_date.month )
		months.map { |m|
			d = Date.new( y, m, 1 )
			Month.new( d ).nth_xday( weekday, nth )
		}.find_all { |d| in_range?( d ) }
  end

	def create_by_monthday( item_params )
		dates_by_monthday.each { |d| 
      item_params[:trx_date] = d
      items.create( item_params )
		}
  end

	def create_by_weekday( weekday, nth )
		dates_by_weekday( weekday, nth ).each { |d| 
      items.create( trx_date: d ) 
		}
  end

  def in_range?( d )
    ( start_date <= d ) and ( d <= end_date )
  end
end
