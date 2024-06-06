require 'rails_helper'

RSpec.describe Habit, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:plant_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:frequency) }
    it { should validate_presence_of(:custom_frequency) }
    it { should validate_presence_of(:start_datetime) }
    it { should validate_presence_of(:end_datetime) }
    it { should validate_presence_of(:status) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:plant) }
    it { should have_many(:progresses).dependent(:destroy) }
  end

  describe 'after_create_commit' do
    it 'creates progresses for each day between start_datetime and end_datetime with frequency is daily' do
      user = User.create!({
        name: "John Doe",
        email: "john@gmail.com"
      })

      plant = Plant.create!({
        style: "Flower1001",
        stem: "Stem.008",
        seed: "Seed.007",
        petal: "Petal.007",
        leaf: "Leaf.009",
        scale: 1,
        grow_rate: 0.4
      })

      habit = Habit.create!({
        name: "Mediate",
        description: "Spend 10 minutes meditating right after waking up",
        user_id: user.id,
        plant_id: plant.id,
        frequency: 0,
        custom_frequency: {
          'monday': true,
          'tuesday': true,
          'wednesday': true,
          'thursday': true,
          'friday': true,
          'saturday': true,
          'sunday': true
        },
        start_datetime: DateTime.new(2024,5,1),
        end_datetime: DateTime.new(2024,5,10),
        status: 0
      })
      expected_days = (DateTime.new(2024,5,1).to_date..DateTime.new(2024,5,10).to_date).count

      expect(habit.progresses.count).to eq(expected_days)
    end

    it 'creates progresses for each day between start_datetime and end_datetime with frequency is weekly' do
      user = User.create!({
        name: "John Doe",
        email: "john@gmail.com"
      })
      plant = Plant.create!({
        style: "Flower1001",
        stem: "Stem.008",
        seed: "Seed.007",
        petal: "Petal.007",
        leaf: "Leaf.009",
        scale: 1,
        grow_rate: 0.4
      })
      habit = Habit.create!({
        name: "Mediate",
        description: "Spend 10 minutes meditating right after waking up",
        user_id: user.id,
        plant_id: plant.id,
        frequency: 1,
        custom_frequency: {
          'monday': true,
          'tuesday': false,
          'wednesday': true,
          'thursday': false,
          'friday': true,
          'saturday': false,
          'sunday': false
        },
        start_datetime: DateTime.new(2024,5,1),
        end_datetime: DateTime.new(2024,5,20),
        status: 0
      })
      expect(habit.progresses.count).to eq(9)
    end

    it 'creates progresses for each day between start_datetime and end_datetime with frequency is monthly' do
      user = User.create!({
        name: "John Doe",
        email: "john@gmail.com"
      })
      plant = Plant.create!({
        style: "Flower1001",
        stem: "Stem.008",
        seed: "Seed.007",
        petal: "Petal.007",
        leaf: "Leaf.009",
        scale: 1,
        grow_rate: 0.4
      })
      habit = Habit.create!({
        name: "Mediate",
        description: "Spend 10 minutes meditating right after waking up",
        user_id: user.id,
        plant_id: plant.id,
        frequency: 2,
        custom_frequency: {
          'monday': true,
          'tuesday': false,
          'wednesday': false,
          'thursday': false,
          'friday': false,
          'saturday': false,
          'sunday': false
        },
        start_datetime: DateTime.new(2024,5,1),
        end_datetime: DateTime.new(2024,12,1),
        status: 0
      })
      expect(habit.progresses.count).to eq(7)
    end
  end
end
