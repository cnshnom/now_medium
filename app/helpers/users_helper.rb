module UsersHelper
    def avatar(user, size: 250)
        image_tag user.avatar.variant(resize_to_fill: [size, nil]), class: 'user-avatar' if user.avatar.attached?
      end
   
  end
  