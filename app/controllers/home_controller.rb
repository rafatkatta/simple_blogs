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
  
  def blog
     @blog = Blog.find(params[:id])
     @bloger = @blog.user.name
     @messages = @blog.masseges.where.not(publiched_at: nil).order(:updated_at)
     render json: {blog: @blog, bloger: @bloger,  messages: @messages}  
  end 

  def add_comment
    @commentator = Commentator.where("firstname LIKE '%?%' OR lastname LIKE '%?%' AND email = '?'", 
                                   params[firstname], params[lastname], params[email])
    if comentanor.blank?
     @commentator= Commentator.create!(firstname: params[firstname], 
                                      lastname: params[lastname], 
                                      email: params[email])
                                    
    end
    @comment= Comment.create!(commentator: @commemtator,  massege_id: params[:massege_id],  content: params[:content])
    rende json: {commentator: @commentator,  comment: @comment}
  end

end
