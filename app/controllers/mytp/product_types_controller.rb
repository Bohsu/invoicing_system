# -*- encoding : utf-8 -*-

class Mytp::ProductTypesController < Mytp::BaseController
  
  before_filter :per_load, :except => [:index, :new, :create]

  def index
     @product_types = ProductType.order("id desc").page(params[:page]).per(30)
  end

  def new
    @product_type = ProductType.new()  
  end

  def create
    @product_type = ProductType.new(params[:product_type])
    flash_msg(:success) if @product_type.save
    respond_back(@product_type)
  end

  def edit
    
  end

  def update
    flash_msg(:success) if @product_type.update_attributes(params[:product_type]) 
    respond_back(@product_type)
  end

  def destroy
    flash_msg(:success)  if @product_type.destroy
    respond_back(@product_type)
  end

  protected

  def per_load
    @product_type = ProductType.find_by_id(params[:id])
  end

end

