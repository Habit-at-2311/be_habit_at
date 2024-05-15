require 'rails_helper'

RSpec.describe Progress, type: :model do
  describe 'associations' do
    it { should belong_to(:habit) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:datetime) }
  end
end
