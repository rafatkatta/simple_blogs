ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, 
  user_profile_attributes: [:id,  :firstname, :lastname, 
                           :birthday, :birth_country,  :birth_city]
   
  scope_to :current_user, unless: proc{ current_user.admin? } 
  #menu if: proc{ current_user.admin? }   

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.inputs do 
          f.has_many :user_profile do |p|
              p.input :firstname 
              p.input :lastname 
              p.input :birthday, as: :datepicker
              p.input :birth_city
              p.country_select :birth_country 
           end   
      end  
    end
    f.actions
  end

end
