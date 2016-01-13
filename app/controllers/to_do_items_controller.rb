class ToDoItemsController < ApplicationController
  #For sorting table headers
  helper_method :sort_column, :sort_direction

  def index
    @to_do_items = current_user.to_do_items.order(sort_column + " " + sort_direction)
  end

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

  def sort_column
    current_user.to_do_items.column_names.include?(params[:sort]) ? params[:sort] : "content"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
