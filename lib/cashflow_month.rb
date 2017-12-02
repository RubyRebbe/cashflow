require 'date'
require "./lib/month.rb"

class CashflowMonth
  def initialize( date )
    @month = Month.new( date )
  end

	def date
    @month.date
  end

	def weeks
    @month.weeks.map { |w|
      w.map { |d| 
        items = !d.nil? ? Item.where( trx_date: d ) : []
        {
				  date: d,
					items: items
				}
      }
    }
  end
end # class CashflowMonth
