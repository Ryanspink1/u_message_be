class Api::V1::FriendshipsController < ApplicationController
  before_action :authenticate_user

  def create
    friend      = User.find_by(email: friendship_params[:friend_email])
    @friendship = current_user.friendships.new(friend: friend)

    if @friendship.save
      render json: @friendship
    else
      render json: @friendship.errors, status: :bad_request
    end
  end

  def show
    if @friendship = Friendship.find(friendship_params[:id])
      render json: @friendship
    else
      render json: @friendship.errors, status: :bad_request
    end
  end

  def index
    @friends         = User.approved(current_user)
    @friend_requests = User.unapproved(current_user)

    render json: {
                  friends:         @friends,
                  friend_requests: @friend_requests
                 }
  end

  def update
    @friendship = Friendship.find_by(user_id: friendship_params[:id], friend: current_user)

    if @friendship.update( approved: 'yes' )
      render json: @friendship
    else
      render json: @friendship.errors, status: :bad_request
    end
  end

  def destroy
    @friendship = Friendship.find_by(user_id: friendship_params[:id], friend: current_user)
    if Friendship.delete_pair(@friendship)
      render status: :no_content
    else
      render json: @friend_request.errors, status: :bad_request
    end
  end

  private

  def friendship_params
    params.permit(:id, :friend_email)
  end
end
