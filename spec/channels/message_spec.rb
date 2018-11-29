require 'rails_helper'

RSpec.describe Api::V1::MessagesController do
  describe "POST #create" do
    user = User.create(id:1, email:"ham@ham.com", password:"ham")
    convo = user.conversations.create(id:1)
    it 'creates and broadcasts a message' do
      expect { post :create, params: { text: 'Cool!', conversation_id:1 } }.to
      have_broadcasted_to("Conversation-1").with(text: 'Cool!')
    end
  end
end
