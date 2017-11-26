require 'pp'

class KashflowsController < ApplicationController
  before_action :set_kashflow, only: [:show, :edit, :update, :destroy, :foo]

  # GET /kashflows
  # GET /kashflows.json
  def index
    @kashflows = Kashflow.all
  end

  # GET /kashflows/1
  # GET /kashflows/1.json
  def show
		@start_date = params[:start_date].blank? ? nil : Date.parse( params[:start_date] )
		@end_date = params[:end_date].blank? ? nil : Date.parse( params[:end_date] )
		@range = @kashflow.date_range( @start_date, @end_date )
		@title = (@range.length == @kashflow.items.length) ?
      "all" : "from #{@start_date} to #{@end_date}"
  end

  # GET /kashflows/new
  def new
    @kashflow = Kashflow.new
  end

  # GET /kashflows/1/edit
  def edit
  end

  # POST /kashflows
  # POST /kashflows.json
  def create
    @kashflow = Kashflow.new(kashflow_params)

    respond_to do |format|
      if @kashflow.save
        format.html { redirect_to @kashflow, notice: 'Kashflow was successfully created.' }
        format.json { render :show, status: :created, location: @kashflow }
      else
        format.html { render :new }
        format.json { render json: @kashflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kashflows/1
  # PATCH/PUT /kashflows/1.json
  def update
    respond_to do |format|
      if @kashflow.update(kashflow_params)
        format.html { redirect_to @kashflow, notice: 'Kashflow was successfully updated.' }
        format.json { render :show, status: :ok, location: @kashflow }
      else
        format.html { render :edit }
        format.json { render json: @kashflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kashflows/1
  # DELETE /kashflows/1.json
  def destroy
    @kashflow.destroy
    respond_to do |format|
      format.html { redirect_to kashflows_url, notice: 'Kashflow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

	def foo
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kashflow
      @kashflow = Kashflow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kashflow_params
	  	params.require(:kashflow).permit(:year, :start_date, :end_date )
    end
end
