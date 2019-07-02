class SaltsController < ApplicationController
  before_action :find_user!

  def show
    render json: SaltSerializer.new(user.salt)
  end

  private

  def find_user!
    render_not_found user_name: params[:user_name] unless user
  end

  def user
    @user ||= User.find_by_name params[:user_name]
  end
end
