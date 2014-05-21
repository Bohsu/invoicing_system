# -*- encoding : utf-8 -*-

class Mytp::ProductsController < Mytp::BaseController
  
  before_filter :per_load, :except => [:index, :new, :create]

  def index
     @products = Product.order("id desc").page(params[:page]).per(30)
  end

  def show

  end

  def new
    @product = Product.new()  
  end

  def create
    @product = Product.new(params[:product])
    flash_msg(:success) if @product.save
    respond_back(@product)
  end

  def edit
    
  end

  def update
    flash_msg(:success) if @product.update_attributes(params[:Product]) 
    respond_back(@product)
  end

  def destroy
    flash_msg(:success)  if @product.destroy
    respond_back(@product)
  end

  protected

  def per_load
    @product = Product.find_by_id(params[:id])
  end

end

