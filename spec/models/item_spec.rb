# == Schema Information
#
# Table name: items
#
#  id                :integer          not null, primary key
#  trx_type          :string
#  trx_date          :date
#  amount            :float
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  kashflow_id       :integer
#  recurrent_item_id :integer
#

require 'rails_helper'

describe Item do
  it "can have a volatile (non-persistent) attribute" do
    i = Item.new
		i.balance = 300
		i.balance.should == 300
  end
end
