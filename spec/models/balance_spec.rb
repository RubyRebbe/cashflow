class MonthRange
  attr_accessor :months

	def initialize( months = [] )
	 @months = months
  end

	def set_item_balance_range
    b = 0

    @months.each { |m|
      m.items.each { |i|
				b = b + i.amount
        i.balance_range = b
      }
    }
  end
end

class Month
  attr_accessor :balance_month, :balance_range
  attr_accessor :items

	def initialize( items = [] )
   @balance_month = 0
	 @balance_range = 0
	 @items = items
  end

	def set_item_balance_month
    b = 0
		@items.each { |i|
      b = b + i.amount
			i.balance_month = b
    }
  end
end

class Xitem
  attr_accessor :balance_month, :balance_range
  attr_accessor :amount

	def initialize( amount )
    @balance_month = 0
		@balance_range = 0
    @amount = amount
  end
end

describe "Balance" do
  before :all do
    @jan = Month.new( [ Xitem.new( 10 ), Xitem.new( 20 ) ] )
    @feb = Month.new( [ Xitem.new( 30 ), Xitem.new( 40 ) ] )
		@range = MonthRange.new( [ @jan, @feb ] )
  end

	it "can initialize a month with items" do
    @jan.items.map { |i| i.amount }.should == [ 10, 20 ]
  end

	it "can initialize a month range  with months" do
		@range.months.length.should == 2
		@range.months.map { |m|
      m.items.map { |i| i.amount }
    }.should == [
      [ 10, 20 ],
      [ 30, 40 ]
    ]
  end

	it "can set the item balances in month" do
		@range.months.each { |m| m.set_item_balance_month }
		@range.months.map { |m| 
      m.items.map { |i| i.balance_month }
		}.should == [
      [ 10, 30 ],
      [ 30, 70 ]
    ]
  end

	it "can set the item balances in the range" do
	  @range.set_item_balance_range
		@range.months.map { |m| 
      m.items.map { |i| i.balance_range }
		}.should == [
      [ 10, 30 ],
      [ 60, 100 ]
    ]
  end
end
