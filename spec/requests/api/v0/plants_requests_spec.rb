require "rails_helper"

RSpec.describe "Plants Api", type: :request do 
	before(:each) do 
		@headers = { "Content-Type" => "application/json", "accept" => 'application/json' }

		@plant_1 = Plant.create!({
      style: "Flower1001",
      stem: "Stem.008",
      seed: "Seed.007",
      petal: "Petal.007",
      leaf: "Leaf.009",
      scale: 1
    })

    @plant_2 = Plant.create!({
      style: "Flower2001",
      stem: "Stem.009",
      seed: "Seed.008",
      petal: "Petal.008",
      leaf: "Leaf.010",
      scale: 0.4
    })

    @plant_3 = Plant.create!({
      style: "Flower3001",
      stem: "Stem.010",
      seed: "Seed.009",
      petal: "Petal.009",
      leaf: "Leaf.011",
      scale: 1
    })

    @plant_4 = Plant.create!({
      style: "Flower4001",
      stem: "Stem.011",
      seed: "Seed.010",
      petal: "Petal.010",
      leaf: "Leaf.012",
      scale: 1
    })
	end

	describe "plants#index" do 
		it "returns the data for every plant in the system" do 
			get "/api/v0/plants", headers: @headers
		
			result = JSON.parse(response.body, symbolize_names: true)
			data = result[:data]

			expect(response.status).to eq(200)
			expect(result).to be_a Hash
			expect(result.keys).to match_array([:data])
			expect(data).to be_an Array
			expect(data.count).to eq(4)
			
			# test first plant's non-'attributes' key/values
			expect(data.first.keys).to match_array([:id, :type, :attributes])
			expect(data.first[:id]).to be_a String
			expect(data.first[:type]).to be_a String
			expect(data.first[:type]).to eq("plant")
			expect(data.first[:attributes]).to be_a Hash
			expect(data.first[:attributes].keys).to match_array([:style, :stem, :seed, :petal, :leaf, :scale])

			# explicit attributes comparison for first plant
			expect(data.first[:attributes][:style]).to be_a String
			expect(data.first[:attributes][:style]).to eq("Flower1001")
			expect(data.first[:attributes][:stem]).to be_a String
			expect(data.first[:attributes][:stem]).to eq("Stem.008")
			expect(data.first[:attributes][:seed]).to be_a String
			expect(data.first[:attributes][:seed]).to eq("Seed.007")
			expect(data.first[:attributes][:petal]).to be_a String
			expect(data.first[:attributes][:petal]).to eq("Petal.007")
			expect(data.first[:attributes][:leaf]).to be_a String
			expect(data.first[:attributes][:leaf]).to eq("Leaf.009")
			expect(data.first[:attributes][:scale]).to be_an Integer
			expect(data.first[:attributes][:scale]).to eq(1)

			# plants 1, 2, and 3 attr type/value tests
			(1..3).to_a.each do |n|
				expect(data[n][:attributes][:style]).to be_a String
				expect(data[n][:attributes][:style]).to eq(Plant.all[n].style)
				expect(data[n][:attributes][:stem]).to be_a String
				expect(data[n][:attributes][:stem]).to eq(Plant.all[n].stem)
				expect(data[n][:attributes][:seed]).to be_a String
				expect(data[n][:attributes][:seed]).to eq(Plant.all[n].seed)
				expect(data[n][:attributes][:petal]).to be_a String
				expect(data[n][:attributes][:petal]).to eq(Plant.all[n].petal)
				expect(data[n][:attributes][:leaf]).to be_a String
				expect(data[n][:attributes][:leaf]).to eq(Plant.all[n].leaf)
				expect(data[n][:attributes][:scale]).to be_an Integer
				expect(data[n][:attributes][:scale]).to eq(Plant.all[n].scale)
			end
		end
	end
end 