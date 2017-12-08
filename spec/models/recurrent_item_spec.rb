require 'rails_helper'

describe RecurrentItem do
  before :all do
		RecurrentItem.delete_all

		@ritem = RecurrentItem.create(
			start_date: Date.new( 2017, 12, 1),
	    end_date: Date.new( 2017, 12, 31)
    )
  end

  it "has a start_date" do
		RecurrentItem.all.length.should == 1
  end

	it "has a end_date"
	it "start_date and end_date must fall within the same year"
	it "creation creates the associated items in the date range"
	it "associated items share same day of month - start_date day"
	it "destroying it destroys the associated items"
	it "a regular item is optionally associated with a recurrent item"
	it "supports both by date in month  and by nth week day in month"
end
