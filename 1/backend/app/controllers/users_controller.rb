class UsersController < ApplicationController
  before_action :find_user!, only: %i[show password]
  before_action :validate_nonce!, only: %i[password]

  def create
    new_user = User.new new_user_params

    if new_user.save
      Mailers::User::ActivationJob.new(new_user).deliver
      render json: UserSerializer.new(new_user), status: :created
    else
      render json: new_user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: UserSerializer.new(user)
  end

  def password
    
  end

  private

  def find_user!
    render_not_found user_name: params[:name] unless user
  end

  def user
    @user ||= User.find_by_name params[:name]
  end

  def new_user_params
    params.permit(:name, :email)
  end

  def validate_nonce!
    render_unauthorized nonce: 'invalid' unless password_service.valid_nonce?
  end

  def password_service
    @password_service ||= ControllerServices::UsersPasswordService.new user: user, params: params
  end
end
