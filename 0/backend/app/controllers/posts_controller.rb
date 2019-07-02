class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  def index
    posts = Post.all
    render json: PostSerializer.new(posts)
  end

  def show
    render json: PostSerializer.new(@post)
  end

  def create
    post = Post.new(post_params)

    if post.save
      render json: PostSerializer.new(post), status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: PostSerializer.new(@post)
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
  end

  private

  def set_post
    @post = Post.find_by_token!(params[:token])
  rescue ActiveRecord::RecordNotFound
    render json: { token: params[:token] }, status: :not_found
  end

  def post_params
    params.require(:post).permit(:user_id, :sub_id, :title, :url, :body)
  end
end
