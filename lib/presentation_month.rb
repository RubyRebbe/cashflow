require 'date'
require "./lib/month.rb"

class PresentationMonth
  def initialize( month_hash )
    @month_hash = month_hash
		# dummy proof
		@date = month_hash[:items].first.trx_date
		@month = Month.new( @date )
  end

	def month_name
    @month_hash[:month_name]
  end

	def items
    @month_hash[:items]
  end

  # need a finder on Month ... returning week and day index
 	def weeks
    @month.weeks.map { |w|
      w.map { |d| 
        {
				  date: d,
					items: !d.nil? ? items.where( trx_date: d ) : []
				}
      }
    }
  end
end # class CashflowMonth
