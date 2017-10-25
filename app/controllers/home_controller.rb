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
     @messages = @blog.masseges.includes(comments: [:commentator]).where.not(publiched_at: nil).order(:updated_at)

     render json: {blog: @blog.as_json, 
                   bloger: @bloger.as_json,  
                   messages: @messages.as_json(include: [comments: {include: {commentator: {methods: :name}}}])
                  }  
  end 

  def add_comment
    massege = Massege.find(params[:message_id]) 
    commentator = Commentator.where("firstname LIKE ? OR lastname LIKE ? AND email = ?", 
                                   "%#{params[:firstname]}%", "%#{params[:lastname]}%", params[:email]).first

    if commentator.blank?
     commentator = Commentator.create!(firstname: params[:firstname], 
                                      lastname: params[:lastname], 
                                      email: params[:email])
                                    
    end

    @comment= Comment.create!(commentator: commentator,  massege: massege,  content: params[:comment])
    render json: @comment,  include: {commentator: {methods: :name}} 
  end

end
