# -*- encoding : utf-8 -*-

class Mytp::BuysController < Mytp::BaseController
  
  before_filter :per_load, :except => [:index, :new, :create]

  def index
     @buys = Buy.order("id desc").page(params[:page]).per(30)
  end

  def new
    @buy = Buy.new()  
  end

  def create
    @buy = Buy.new(params[:buy])
    flash_msg(:success) if @buy.save
    respond_back(@buy)
  end

  def edit
    
  end

  def update
    flash_msg(:success) if @buy.update_attributes(params[:buy]) 
    respond_back(@buy)
  end

  def destroy
    flash_msg(:success)  if @buy.destroy
    respond_back(@buy)
  end

  protected

  def per_load
    @buy = Buy.find_by_id(params[:id])
  end

end

