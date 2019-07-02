class VotesController < ApplicationController
  before_action :set_voteable, only: %i[create]
  before_action :authenticate_user!, only: %i[create]

  def create
    vote = Vote.find_or_initialize_by user: current_user, voteable: @voteable

    if vote.update vote_params
      render json: VoteSerializer.new(vote), status: :created
    else
      render json: vote.errors, status: :unprocessable_entity
    end
  end

  private

  def set_voteable
    @voteable = Post.find_by_token! params[:post_token]
  rescue ActiveRecord::RecordNotFound
    @voteable = Comment.find_by_token! params[:comment_token]
  rescue ActiveRecord::RecordNotFound
    render json: { token: params[:post_token] || params[:comment_token] }, status: :not_found
  end

  def vote_params
    params.permit(:direction)
  end
end
