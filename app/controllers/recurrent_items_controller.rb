class RecurrentItemsController < ApplicationController
  def index
    @recurrent_items = RecurrentItem.all
  end

  def destroy
    @recurrent_item = RecurrentItem.find(params[:id])
		# assert: at least one item associated with recurrent_item
		@kashflow = @recurrent_item.items.first.kashflow
    @recurrent_item.destroy

    respond_to do |format|
      format.html { redirect_to @kashflow, notice: 'RecurrentItem was successfully destroyed.' }
    end
  end
end
