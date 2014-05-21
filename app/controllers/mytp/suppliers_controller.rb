# -*- encoding : utf-8 -*-

class Mytp::SuppliersController < Mytp::BaseController
  
  before_filter :per_load, :except => [:index, :new, :create]

  def index
     @suppliers = Supplier.order("id desc").page(params[:page]).per(30)
  end

  def new
    @supplier = Supplier.new()  
  end

  def create
    @supplier = Supplier.new(params[:supplier])
    flash_msg(:success) if @supplier.save
    respond_back(@supplier)
  end

  def edit
    
  end

  def update
    flash_msg(:success) if @supplier.update_attributes(params[:supplier]) 
    respond_back(@supplier)
  end

  def destroy
    flash_msg(:success)  if @supplier.destroy
    respond_back(@supplier)
  end

  protected

  def per_load
    @supplier = Supplier.find_by_id(params[:id])
  end

end

