# -*- encoding : utf-8 -*-

class Mytp::PermissionsController < Mytp::BaseController
  
  before_filter :per_load, :except => [:index, :new, :create]

  def index
     @permissions = Permission.all.to_sorted_nodes
  end

  def new
    @permission = Permission.new(:parent_id => params[:parent_id])  
    render :layout => false
  end

  def create
    @permission = Permission.new(params[:permission])
    flash_msg(:success) if @permission.save
    respond_back(@permission)
  end

  def edit
    render :layout=>false
  end

  def update
    flash_msg(:success) if @permission.update_attributes(params[:permission])
    respond_back(@permission)
  end

  def destroy
    if @permission.destroy
      respond_to do |format|
        flash_msg(:success) 
        format.html{respond_back(@permission)}
        format.json{render :json => true}
        # format.json{render :json => {status:'success'}}
      end
    end
  end

  protected

  def per_load
    @permission = Permission.find(params[:id])
    
  end

end

