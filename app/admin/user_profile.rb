ActiveAdmin.register UserProfile do
 permit_params [:id,  :firstname, :lastname, :birthday, :birth_country,  :birth_city]
 menu if: proc{!current_user.is_admin?} 
 actions :all, except: [:destroy]   

end
