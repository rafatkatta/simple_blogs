ActiveAdmin.register Category do
  permit_params :name,  :description
  includes :blogs
  menu if: proc{ current_user.admin? }     
end
