class ProfilesController < ApplicationController
  before_action :set_user

  def show
  end

  def teachings
    @teachings = @user.teachings.order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end
