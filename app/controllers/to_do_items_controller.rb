class ToDoItemsController < ApplicationController

  def new
    @to_do_item = ToDoItem.new
  end

end
