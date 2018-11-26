require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context "validations" do
    it { should validate_presence_of(:user_id)}
    it { should validate_presence_of(:friend_id)}
    it { should validate_presence_of(:approved)}
    # it { should validate_inclusion_of(:approved) in_array:['no', 'yes']}
  end

  context "relationships" do

  end
end
