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

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
