require "rails_helper"

RSpec.describe Plant, type: :model do 
	describe "validations" do 
		it { should validate_presence_of(:style) }
		it { should validate_presence_of(:stem) }
		it { should validate_presence_of(:seed) }
		it { should validate_presence_of(:petal) }
		it { should validate_presence_of(:leaf) }
		it { should validate_presence_of(:scale) }
	end

	describe "relationships" do 
		it { should have_many(:habits) }
	end
end 