class Api::V1::MessagesController < ApplicationController


  def create

  end


  private

  def messages_params
    params.permit(:id, :text, :conversation_id, :other_user_id )
  end

end
