require 'rails_helper'
require 'pp'
require "./lib/month.rb"

describe RecurrentItem do
  before :all do
		RecurrentItem.delete_all
		Item.delete_all

		@ritem = RecurrentItem.create(
			start_date: Date.new( 2017, 1, 1),
	    end_date: Date.new( 2017, 12, 31)
    )
  end

  it "has a start_date" do
		RecurrentItem.all.length.should == 1
		@ritem.start_date.day.should == 1
  end

	it "has a end_date" do
		@ritem.end_date.day.should == 31
  end

	it "start_date and end_date must fall within the same year" do
		@ritem.valid_year?.should == true
  end

	it "can generate all the dates in the range by month-day" do
		r = @ritem.dates_by_monthday
		r.map { |d| d.month }.should == (1..12).to_a
  end

	it "can create all the items in the range by month-day" do
		@ritem.create_by_monthday
		@ritem.items.length.should == 12
  end

	it "associated items share same day of month - start_date day" do
		day = @ritem.start_date.day
		@ritem.items.each { |i| i.trx_date.day.should == day }
  end

	it "can create dates in range by nth weekday in month" do
    @ritem.public_methods.should include :create_by_weekday
		# calculate the months in the range
		( @ritem.start_date.month..@ritem.end_date.month ).to_a.should == 
      ( 1..12 ).to_a
		# use each month to calculate the nth weekday in that month
		# e.g. 3rd Wednesday of month
    weekday = 3
		nth = 3
		expected = [ 18, 15, 15, 19, 17, 21, 19, 16, 20, 18, 15, 20 ]

		dates = @ritem.dates_by_weekday( weekday, nth )
		dates.map { |d| d.day }.should == expected
		# make sure each date fits within the range
		dates.each { |d| @ritem.in_range?( d ) }
  end

	it "can create all the items in the range by week-day" do
		ri = RecurrentItem.create(
			start_date: Date.new( 2017, 1, 1),
	    end_date: Date.new( 2017, 12, 31)
    )

    weekday = 3
		nth = 3
		expected = [ 18, 15, 15, 19, 17, 21, 19, 16, 20, 18, 15, 20 ]

		ri.create_by_weekday( weekday, nth )
		ri.items.length.should == 12
		ri.items.map { |i| i.trx_date.day }.should == expected
  end
end
