# -*- encoding : utf-8 -*-

class Mytp::SellProductsController < Mytp::BaseController
  
  before_filter :per_load
  after_filter :per_update, :only => [:create, :update, :destroy]

  def index
    
  end

  def new
    @sell_product = @sell.sell_products.new()  
  end

  def create
    @sell_product = @sell.sell_products.new(params[:sell_product])
    if @sell_product.save
      @sell_product.update_product("create", '')
      flash_msg(:success)  
    end
    redirect_to mytp_sell_path(@sell)
  end

  def edit
    
  end

  def update
    if @sell_product.update_attributes(params[:sell_product]) 
      @sell_product.update_product("update", params[:old_quantity])
      flash_msg(:success) 
    end
    redirect_to mytp_sell_path(@sell)
  end

  def destroy
    old_quantity = @sell_product.quantity
    if @sell_product.destroy
      @sell_product.update_product("destroy", old_quantity)
      flash_msg(:success)  
    end
    redirect_to mytp_sell_path(@sell)
  end

  def find_product
    @product = Product.find_by_name(params[:name])
    render :json => @product
  end


  protected

  def per_load
    @sell = Sell.find_by_id(params[:sell_id])
    @sell_product = SellProduct.find_by_id(params[:id])
  end

  def per_update
    @sell.update_total_price
  end

end

