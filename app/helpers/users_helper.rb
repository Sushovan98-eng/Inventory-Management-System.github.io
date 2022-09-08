# frozen_string_literal: true

# Here define the User helper methods for the application
module UsersHelper
  def get_user_name_by_id(id)
    user = User.find(id)
    return 'N/A' if user.nil?

    user.name
  end

  def get_user_by_id(id)
    user = User.find(id)
    return nil if user.nil?

    user
  end
end
