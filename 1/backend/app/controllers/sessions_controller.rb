class SessionsController < ApplicationController
  before_action :find_user!, :validate_nonce!, :validate_password!

  def create
    user.nonce.destroy
    render_created SessionSerializer.new(session)
  end

  private

  def find_user!
    render_not_found user_name: params[:user_name] unless user
  end

  def validate_nonce!
    render_unauthorized nonce: 'invalid' unless service.valid_nonce?
  end

  def validate_password!
    render_unauthorized password: 'invalid' unless service.valid_password?
  end

  def user
    @user ||= User.find_by_name params[:user_name]
  end

  def service
    @service ||= ControllerServices::SessionsService.new user: user, params: params
  end

  def session
    @session ||= service.make_session
  end
end
