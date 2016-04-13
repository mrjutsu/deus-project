module ProfileHelper

  def user_full_name
    if current_user.first_name.nil? && current_user.last_name.nil?
      'Nombre no disponible'
    else
      current_user.first_name + ' ' + current_user.last_name
    end
  end

end
