class NoncesController < ApplicationController
  before_action :find_user!

  def create
    nonce = user.tap { |user| user.nonce.destroy if user.nonce }.build_nonce

    if nonce.save
      render json: NonceSerializer.new(nonce), status: :created
    else
      render json: nonce.errors, status: :unprocessable_entity
    end
  end

  private

  def find_user!
    render_not_found user_name: params[:user_name] unless user
  end

  def user
    @user ||= User.find_by_name params[:user_name]
  end
end
