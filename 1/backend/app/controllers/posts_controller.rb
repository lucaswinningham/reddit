class PostsController < ApplicationController
  before_action :set_sub, only: %i[index create]
  before_action :set_user, only: %i[create]
  before_action :set_posts, only: %i[index]
  before_action :authenticate_user!, only: %i[create]

  def index
    render json: PostSerializer.new(@posts)
  end

  def create
    post = Post.new post_params.merge(user: current_user, sub: @sub)

    if post.save
      render json: PostSerializer.new(post), status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  private

  def set_sub
    @sub = Sub.find_by_name! params[:sub_name] if params[:sub_name]
  rescue ActiveRecord::RecordNotFound
    render json: { sub_name: params[:sub_name] }, status: :not_found
  end

  def set_user
    @user = User.find_by_name! params[:user_name] if params[:user_name]
  rescue ActiveRecord::RecordNotFound
    render json: { user_name: params[:user_name] }, status: :not_found
  end

  def set_posts
    @posts = Post.sort
    @posts = @posts.where sub: @sub if @sub
  end

  def post_params
    params.permit(:title, :url)
  end
end
