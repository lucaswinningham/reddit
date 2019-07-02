class CommentsController < ApplicationController
  before_action :set_post, only: %i[index]
  before_action :set_comments, only: %i[index]
  before_action :set_commentable, only: %i[create]
  before_action :authenticate_user!, only: %i[create]

  def index
    render json: CommentSerializer.new(@comments)
  end

  def create
    comment = Comment.new comment_params.merge(user: current_user, commentable: @commentable)

    if comment.save
      render json: CommentSerializer.new(comment), status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find_by_token! params[:post_token] if params[:post_token]
  rescue ActiveRecord::RecordNotFound
    render json: { post_token: params[:post_token] }, status: :not_found
  end

  def set_comments
    @comments = Comment.sort
    @comments = @comments.where commentable: @post if @post
  end

  def set_commentable
    @commentable = Post.find_by_token! params[:post_token]
  rescue ActiveRecord::RecordNotFound
    @commentable = Comment.find_by_token! params[:comment_token]
  rescue ActiveRecord::RecordNotFound
    render json: { token: params[:post_token] || params[:comment_token] }, status: :not_found
  end

  def comment_params
    params.permit(:content)
  end
end
