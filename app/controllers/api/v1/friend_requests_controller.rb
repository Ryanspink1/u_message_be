class Api::V1::FriendRequestsController < ApplicationController
  before_action :authenticate_user

  def create
    friend = User.find_by(friend_request_params[:email])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      render json: @friend_request
    else
      render json: @friend_request.errors, status: :bad_request
    end
  end

  def index
    # @incoming = FriendRequest.where(friend: current_user)
    # @outgoing = current_user.friend_requests
  end

  def destroy
    @friend_request = FriendRequest.find(friend_request_params[:id])
    if @friend_request.delete
      render status: :no_content
    else
      render json: @friend_request.errors, status: :bad_request
    end
  end

  private

  def friend_request_params
    params.permit(:id, :email)
  end
end
