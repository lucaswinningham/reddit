class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    users = User.all
    render json: UserSerializer.new(users)
  end

  def show
    render json: UserSerializer.new(@user)
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find_by_name!(params[:name])
  rescue ActiveRecord::RecordNotFound
    render json: { name: params[:name] }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
