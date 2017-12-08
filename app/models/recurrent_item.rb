class RecurrentItem < ApplicationRecord
  has_many :items, dependent: :destroy
end
