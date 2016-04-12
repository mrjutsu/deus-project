module ApplicationHelper
  def top_navbar
    if user_signed_in?
      render partial: 'layouts/nav'
    else
      render partial: 'layouts/nav_so'
    end
  end
end
