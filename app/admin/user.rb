ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, 
  user_profile_attributes: [:id,  :firstname, :lastname, 
                           :birthday, :birth_country,  :birth_city]
    
    menu label: proc{I18n.t "#{current_user.is_admin? ? 'users':'password'}"}
 
   
  controller do
    disallowed = []
    disallowed << :show if proc{current_user.is_admin?}  
    disallowed << :edit unless proc{current_user.is_admin?}  
    disallowed << :new if proc{current_user.is_admin?}
    disallowed << :destroy if proc{current_user.is_admin?}
    actions :all, except: disallowed
    Rails.logger.debug disallowed
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
        id_column
        column :email
        column :current_sign_in_at
        column :sign_in_count
        column :created_at
        actions
    end    
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
