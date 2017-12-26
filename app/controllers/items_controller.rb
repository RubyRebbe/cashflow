ActionController::Parameters.permit_all_parameters = true

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
		@recurrence = params[:item][:recurrence]
    @item = nil

		if @recurrence == "ordinary" then
      @item = Item.new( item_params )
			@item.kashflow = @kashflow
		elsif @recurrence == "by month day" then
      @item = RecurrentItem.new
			@item.start_date = params[:item][:start_date]
			@item.end_date   = params[:item][:end_date]
			@item.save
			@item.create_by_monthday( @kashflow, item_params )
	  elsif @recurrence == "by week day" then
      @item = RecurrentItem.new
			@item.start_date = params[:item][:start_date]
			@item.end_date   = params[:item][:end_date]
			@item.save
			week_day = params[:item][:week_day].to_i
			nth = params[:item][:nth].to_i
	    @item.create_by_weekday( @kashflow, item_params, week_day, nth )
    end

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
      params.require(:item).permit(:trx_type, :trx_date, :amount, :name, :kashflow_id, :recurrent_item, :recurrence )
    end
end
