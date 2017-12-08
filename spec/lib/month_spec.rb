require 'rails_helper'
require 'date'
require 'pp'
require "./lib/month.rb"

describe Month do
  before :all do
    @month = Month.new( Date.new( 2017, 11) )
  end

  it "represents a month in a year" do
    @month.date.month.should == 11
  end

  it "is initialized by a date object" do
    @month.date.year.should == 2017
  end

	it "can calculate the last day of the month" do
    @month.last_day.day.should == 30
  end

	it "can generate the month array of day dates" do
		@month.days.each { |d| d.class.should == Date }
		@month.days.to_a.length.should == 30
  end

	it "every middle week starts on a Sunday" do
   k = @month.offset( @month.first_day.cwday )
   @month.middle_weeks( k + 1 ).each { |w|
     w.length.should == 7
     w.first.sunday?.should == true
   }
  end

	it "can arrange the days into weeks, Sunday to Saturday" do
    @month.public_methods( false ).should include :weeks
    # pp @month.weeks
  end

	it "can render itself (November 2017) as a string" do
		puts "year: #{@month.date.year}"
		puts "month: #{@month.date.month}"
    puts @month.to_s
  end

	it "can render December 2017" do
		month = Month.new( Date.new( 2017, 12, 1 ) )
		month.date.year.should == 2017
		month.date.month.should == 12
    puts month.to_s
		month.days.map { |d| d.day }.should == 1.upto(31).to_a
		month.weeks.map { |w| w.first }.each { |d|
			( d.nil? or d.sunday? ).should == true
    }
  end

	it "can calculate the first X-day of each month" do
		x = 5 # Friday

		# actual date of first friday of each month in 2017
		expected = [ 6, 3, 3, 7, 5, 2, 7, 4, 1, 6, 3, 1 ] 

		months = (1..12).to_a.map { |m| Month.new( Date.new( 2017, m) ) }
		months.map { |m| m.first_xday( x ).day }.should == expected
  end

	it "can calculate the third Wednesday of each month" do
		x = 5 # Friday
		@month.nth_xday( x, 2 ).day.should == 10

		# third Wednesday of each month in 2017
		x = 3 # Wednesday
		expected = [ 18, 15, 15, 19, 17, 21, 19, 16, 20, 18, 15, 20 ]

		months = (1..12).to_a.map { |m| Month.new( Date.new( 2017, m) ) }
		months.map { |m| m.nth_xday( x , 3).day }.should == expected

  end
end
