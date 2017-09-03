ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, 
  user_profile_attributes: [:id,  :firstname, :lastname, 
                           :birthday, :birth_country,  :birth_city]
  includes :blogs,  :user_profile
    
  menu label: proc{I18n.t "#{current_user.is_admin? ? 'users':'password'}"}
  
    
  controller do
    def scoped_collection
      if current_user.is_admin?
        User.all
      else
        User.where(id: current_user.id)
      end
    end
  end  
  
    member_action :change_admin_status,  method: :post do
        user = User.find(params[:id])
        user.update_attribute :admin, !user.admin 
        redirect_to action: :index, notice: "Status Changed"
    end

    member_action :change_approval_status,  method: :post do
        user = User.find(params[:id])
        if user.deactivate_at.nil?
           user.update_attribute :deactivate_at, DateTime.now 
        else
           user.update_attribute :deactivate_at, nil 
        end    
        redirect_to action: :index, notice: "Status Changed"
    end
  
  index do
    if current_user.is_admin?  
        selectable_column
        id_column
        column :email
        column :name
        column :birthday
        column :birth_city
        column :birth_country
        column :current_sign_in_at
        column :sign_in_count
        column :created_at
        column :is_admin? do |user|
            link_to "#{user.is_admin? ? 'Yes' : 'NO'}",change_admin_status_admin_user_path(user.id), method: :post, class: "status_tag #{user.is_admin? ? 'yes' : 'no'}"
          end
        column :approved?do |user|
            link_to "#{user.approved? ? 'Yes' : 'NO'}",change_approval_status_admin_user_path(user.id), method: :post, class: "status_tag #{user.approved? ? 'yes' : 'no'}"
          end
        actions
    else
        selectable_column
        column :email
        column :current_sign_in_at
        column :sign_in_count
        column :created_at
        column ' ' do |user|
            link_to "Edit", edit_admin_user_path(user.id) 
        end    
    end    
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      if current_user.is_admin? 
        f.input :email
        f.inputs "User Profile" do
        f.semantic_fields_for :user_profile do |p|
            p.input :firstname
            p.input :lastname      
            p.input :birthday
            p.input :birth_city
            p.input :birth_country  
         end 
        end   
      else  
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end
  
   show do
    unless current_user.is_admin? 
       attributes_table do
        row :email
        row :name
        row :birthday
        row :birth_city
        row :birth_country
        row :current_sign_in_at
        row :sign_in_count
        row :created_at
       end    
    else
     default_main_content 
    end   
   end
end
