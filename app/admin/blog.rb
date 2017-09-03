ActiveAdmin.register Blog do
    #belongs_to :user
    #belongs_to :category
    permit_params :name, :description,  :user_id, :category_id
    includes :masseges
    
    scope_to :current_user, unless: proc{ current_user.admin? }
    controller do
      def scoped_collection
        if current_user.is_admin?
          Blog.all
        else
          Blog.where(user_id: current_user.id)        
        end
      end
    end  
    
   index do
    selectable_column
    if current_user.is_admin?   
        column :id
        column :user do  |blog|
            blog.user.name
        end   
    end 
    column :category
    column :description
    column :massegs do |blog|
      link_to 'messages', admin_blog_masseges_path(blog.id)
    end    
    actions
   end
   
   show title: :name do
    attributes_table do
      if current_user.is_admin?   
        row :id
        row :user      
      end
      row :name
      row :description
      row :category do |blog|
          if current_user.is_admin?
            link_to blog.category.name, admin_category_path(blog.category.id)  
          else    
            blog.category.name
          end
      end    
      row :created_at
      row :updated_at
    end
    #active_admin_comments
   end
end
