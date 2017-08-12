ActiveAdmin.register Blog do
    #belongs_to :user
    #belongs_to :category
    permit_params :name, :description,  :user_id, :category_id
    scope_to :current_user, unless: proc{ current_user.admin? }

end
