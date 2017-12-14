# == Schema Information
#
# Table name: kashflows
#
#  id         :integer          not null, primary key
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Kashflow, :type => :model do
  before :all do
    @kashflow = Kashflow.create
    @start_date = Date.new( 2017, 11, 23)
    @end_date = Date.new( 2017, 12, 31)
  end

  it "has a method to filter items by date range" do
    @kashflow.public_methods( false).should include :date_range
  end

  it "date_range returns empty list when there are no items" do
    @kashflow.items.should be_empty
    @kashflow.date_range( @start_date, @end_date ).should be_empty
  end

  it "date_range handles out of range items" do
    out_range = Item.new( trx_date: Date.new( 2016, 1, 1) )
		out_range.save
    @kashflow.items << out_range 
    @kashflow.save
    @kashflow.date_range( @start_date, @end_date ).should be_empty
  end

  it "date_range handles in range items" do
    in_range = Item.new( trx_date: Date.new( 2017, 12, 3) )
    @kashflow.items << in_range 
    @kashflow.date_range( @start_date, @end_date ).length.should == 1
    i = @kashflow.date_range( @start_date, @end_date ).first
    i.trx_date.should == in_range.trx_date
  end

  it "can find the first date on which the range balance <= limit" do
    @kashflow.public_methods( false ).should include :threshold
  end
end
