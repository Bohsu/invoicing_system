# -*- encoding : utf-8 -*-

class Mytp::UnitsController < Mytp::BaseController
  
  before_filter :per_load, :except => [:index, :new, :create]

  def index
     @units = Unit.order("id desc").page(params[:page]).per(30)
  end

  def new
    @unit = Unit.new()  
  end

  def create
    @unit = Unit.new(params[:unit])
    flash_msg(:success) if @unit.save
    respond_back(@unit)
  end

  def edit
    
  end

  def update
    flash_msg(:success) if @unit.update_attributes(params[:Unit]) 
    respond_back(@unit)
  end

  def destroy
    flash_msg(:success)  if @unit.destroy
    respond_back(@unit)
  end

  protected

  def per_load
    @unit = Unit.find_by_id(params[:id])
  end

end

