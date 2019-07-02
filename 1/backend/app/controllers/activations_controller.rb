class ActivationsController < ApplicationController
  before_action :find_user!, :validate_nonce!, :authenticate_token!

  def update
    if user.update hashed_password: service.password
      user.activation.destroy
      render_created SessionSerializer.new(session)
    else
      render_unprocessable_entity user.errors
    end
  end

  private

  def find_user!
    render_not_found user_name: params[:user_name] unless user
  end

  def validate_nonce!
    render_unauthorized nonce: 'invalid' unless service.valid_nonce?
  end

  def authenticate_token!
    render_unauthorized token: 'invalid' unless service.authentic_token?
  end

  def user
    @user ||= User.find_by_name params[:user_name]
  end

  def service
    @service ||= ControllerServices::ActivationsService.new user: user, params: params
  end

  def session
    @session ||= service.make_session
  end
end
