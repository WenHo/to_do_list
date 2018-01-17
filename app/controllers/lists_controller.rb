class ListsController < ApplicationController
	def index
    @lists = List.all
  end
  def new
	  @list = List.new
	end
	def create
	  @list = List.new(list_params)
	  @list.save

	  redirect_to lists_url
	end
	def show
	  @list = List.find(params[:id])
	end
	def update
	  @list = List.find(params[:id])
	  @list.update_attributes(list_params)
	
  	redirect_to list_path(@list)
	end
  def edit
  	@list = List.find(params[:id])
	end
	

	def destroy
    
    if DateTime.current < set_task.due_date
      @list.destroy
      # 跳出警告訊息，告知成功刪除
      flash[:alert] = 'List was successfully deleted !!'
      # 重新發出 request，導往列表頁。對瀏覽器來說會重整頁面
      redirect_to lists_path
    else
      # 跳出警告訊息，告知過期
      flash[:alert] = 'List is overdue, can not be deleted !!'
      # 重新發出 request，導往列表頁。對瀏覽器來說會重整頁面
      redirect_to lists_path
    end
  end
	
	private
	def set_task
    @list = List.find(params[:id])
  end
	def list_params
	  params.require(:list).permit(:name, :due_date, :note,)
	end

  
end
