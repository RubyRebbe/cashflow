require 'rails_helper'

describe Item do
  it "can have a volatile (non-persistent) attribute" do
    i = Item.new
		i.balance = 300
		i.balance.should == 300
  end
end
