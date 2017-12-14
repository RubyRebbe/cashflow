class RecurrentItemsController < ApplicationController
  def index
    @recurrent_items = RecurrentItem.all
  end
end
