# -*- encoding : utf-8 -*-

class Mytp::SellsController < Mytp::BaseController
  
  before_filter :per_load, :except => [:index, :new, :create]

  def index
     @sells = Sell.order("id desc").page(params[:page]).per(30)
  end

  def new
    @sell = Sell.new(:code => build_code)  
  end

  def create
    @sell = Sell.new(params[:sell])
    flash_msg(:success) if @sell.save
    redirect_to :action => :show, :id => @sell.id
  end

  def edit
    
  end

  def update
    flash_msg(:success) if @sell.update_attributes(params[:sell]) 
    respond_back(@sell)
  end

  def destroy
    flash_msg(:success)  if @sell.destroy
    respond_back(@sell)
  end

  def find_customer
    @customer = Customer.find_by_name(params[:name])
    render :json => @customer
  end

  def print_show
    render :layout => false
  end

  protected

  def per_load
    @sell = Sell.find_by_id(params[:id])
  end

end

