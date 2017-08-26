ActiveAdmin.register Blog do
    #belongs_to :user
    #belongs_to :category
    permit_params :name, :description,  :user_id, :category_id
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
  
    
end
