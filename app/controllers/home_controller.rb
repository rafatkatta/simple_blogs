class HomeController < ApplicationController
  def index

  end
  
  def categories
    @categories = Category.all
    render json: @categories  
  end 

  def blogs
     @blogs = Blog.where(category_id: params[:id]).order(:updated_at)
     render json: @blogs   
  end
end
