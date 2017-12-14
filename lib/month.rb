# require 'rails_helper'
require 'date'

class Month
  DPW = 7

  attr_accessor :date

  def initialize( date )
    @date = date
		@days = days
  end

	def last_day
    y = @date.year
		m = @date.month
		Date.new( y, m, -1)
  end

	def first_day
    y = @date.year
		m = @date.month
    Date.new( y, m, 1 )
  end

	def days
		first_day.upto( last_day ).to_a
  end

	# organize the days into weeks
	# a week runs Sunday to Saturday
	# can be padded on left or right with nils
	def weeks
		k = offset( first_day.cwday )

    [ first_week( k ) ] + middle_weeks( DPW - k )
  end

	def first_week( k )
		Array.new(k) + grab( DPW - k, @days )
  end

	def offset( cwday )
    cwday % DPW
  end

	def grab( amount, day_list )
	  day_list[0, amount]
  end

	def middle_weeks( k)
    r = []
		remaining_days = @days[k..-1]

		while remaining_days.length >= DPW do
      r << grab( DPW, remaining_days )
		  remaining_days = remaining_days[DPW..-1]
    end

		# assert: remaining_days.length < DPW 
		if remaining_days.length > 0 then
      r << last_week( remaining_days )
    end

		r
  end

	# pre-condition: 0 < remaining_days.length < DPW 
	def last_week( remaining_days )
    pad = DPW - remaining_days.length
		remaining_days + Array.new( pad )
  end

	# returns first date in month which matches day of week x
	# argument x has dimension of offset of cwday
  def first_xday( x )
		o = offset( first_day.cwday )
    i = ( x - o ) + ( ( x < o ) ? Month::DPW : 0 )

		(first_day + i)
  end

  def nth_xday( x, n = 1 )
		o = offset( first_day.cwday )
    i = ( x - o ) + ( ( x < o ) ? Month::DPW : 0 )

		(first_day + i) + (n - 1)*DPW
  end

	def to_s
		weeks.map { |w| week_to_s( w ) }.reduce("") { |s,e|
      s + "\n" + e
    }
  end

	def week_to_s( w )
		"| " + w.map { |d| 
      ( d.nil? ? "" : d.day.to_s ) + " | " 
		}. reduce("") { |s,e| s + e }
  end
end
