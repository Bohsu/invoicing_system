# -*- encoding : utf-8 -*-

class Mytp::CustomersController < Mytp::BaseController
  
  before_filter :per_load, :except => [:index, :new, :create]

  def index
     @customers = Customer.order("id desc").page(params[:page]).per(30)
  end

  def new
    @customer = Customer.new()  
  end

  def create
    @customer = Customer.new(params[:customer])
    flash_msg(:success) if @customer.save
    respond_back(@customer)
  end

  def edit
    
  end

  def update
    flash_msg(:success) if @customer.update_attributes(params[:customer]) 
    respond_back(@customer)
  end

  def destroy
    flash_msg(:success)  if @customer.destroy
    respond_back(@customer)
  end

  protected

  def per_load
    @customer = Customer.find_by_id(params[:id])
  end

end

