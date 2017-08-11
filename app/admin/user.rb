ActiveAdmin.register User do
	permit_params :email, :firstname, :lastname, :password, :password_confirmation, :country, :date_of_birth, :language
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
	index do
    selectable_column
    id_column
    column :email
    column :firstname
    # column :current_sign_in_at
    # column :sign_in_count
    column :created_at

    actions
  end

   filter :posts
   filter :bookmarks
   filter :bookmarkedposts
   filter :friendships
   filter :pending_friendships
   filter :friends
   filter :rejected_friends
   filter :inverse_friendships
   filter :inverse_friends
   filter :email
   filter :unconfirmed_mail
     
  form do |f|
    f.inputs do
      f.input :email
      f.input :firstname
      f.input :lastname
      f.input :password
      f.input :password_confirmation
      f.input :country
      f.input :date_of_birth
      f.input :language
    end
    f.actions
  end

	end

      

