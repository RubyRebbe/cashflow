class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /items/new
  def new
    @item = Item.new
    @kashflow = Kashflow.find( params[ "kashflow_id"])
  end

  # GET /items/1/edit
  def edit
	  @kashflow = @item.kashflow
  end

  # POST /items
  # POST /items.json
  def create
    @kashflow = Kashflow.find( params[ "kashflow_id"])
    @item = Item.new(item_params)
		@item.kashflow = @kashflow

    respond_to do |format|
      if @item.save
        format.html { redirect_to @kashflow, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
		@kashflow = @item.kashflow

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @kashflow, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
		@kashflow = @item.kashflow
    @item.destroy

    respond_to do |format|
      format.html { redirect_to @kashflow, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:trx_type, :trx_date, :amount, :name, :kashflow_id)
    end
end
