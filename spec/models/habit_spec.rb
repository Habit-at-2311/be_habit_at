require 'rails_helper'

RSpec.describe Habit, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:frequency) }
    it { should validate_presence_of(:start_datetime) }
    it { should validate_presence_of(:end_datetime) }
    it { should validate_presence_of(:status) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:progresses).dependent(:destroy) }
  end

  describe 'after_create_commit' do
    it 'creates progresses for each day between start_datetime and end_datetime' do
      user = User.create!({
        name: "John Dunbar",
        email: "john@gmail.com"
      })
      habit = Habit.create!({
        name: "Mediate",
        description: "Spend 10 minutes meditating right after waking up",
        user_id: user.id,
        frequency: 0,
        start_datetime: DateTime.new(2024,5,1),
        end_datetime: DateTime.new(2024,5,10),
        status: 0
      })
      expected_days = (DateTime.new(2024,5,1).to_date..DateTime.new(2024,5,10).to_date).count

      expect(habit.progresses.count).to eq(expected_days)
    end
  end
end
