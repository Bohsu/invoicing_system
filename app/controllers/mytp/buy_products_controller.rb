# -*- encoding : utf-8 -*-

class Mytp::BuyProductsController < Mytp::BaseController
  
  before_filter :per_load
  after_filter :per_update, :only => [:create, :update, :destroy]

  def index
    
  end

  def new
    @buy_product = @buy.buy_products.new()  
  end

  def create
    @buy_product = @buy.buy_products.new(params[:buy_product])
    if @buy_product.save
      @buy_product.update_product("create", '')
      flash_msg(:success)  
    end
    redirect_to mytp_buy_path(@buy)
  end

  def edit
    
  end

  def update
    if @buy_product.update_attributes(params[:buy_product]) 
      @buy_product.update_product("update", params[:old_quantity])
      flash_msg(:success) 
    end
    redirect_to mytp_buy_path(@buy)
  end

  def destroy
    old_quantity = @buy_product.quantity
    if @buy_product.destroy
      @buy_product.update_product("destroy", old_quantity)
      flash_msg(:success)  
    end
    redirect_to mytp_buy_path(@buy)
  end

  def find_product
    @product = Product.find_by_name(params[:name])
    render :json => @product
  end


  protected

  def per_load
    @buy = Buy.find_by_id(params[:buy_id])
    @buy_product = BuyProduct.find_by_id(params[:id])
  end

  def per_update
    
    @buy.update_total_price
  end

end

