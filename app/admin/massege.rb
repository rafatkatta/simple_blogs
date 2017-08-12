ActiveAdmin.register Massege do
    belongs_to :blog
    permit_params :title, :content, :blog_id
    scope_to :current_user, unless: proc{ current_user.admin? }
end
