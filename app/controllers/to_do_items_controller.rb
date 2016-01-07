class ToDoItemsController < ApplicationController

  def new
    @to_do_item = ToDoItem.new
  end

  def create
    @user = current_user
    @item = @user.to_do_items.create(to_do_item_params)
    if @item.save
      flash[:notice] = 'Item successfully created.'
      redirect_to :back
    else
      flash[:notice] = 'Error saving your item.'
      render('new')
    end
  end

  private
    def to_do_item_params
      params.require(:to_do_item).permit(:content, :creator_id)
    end
end
