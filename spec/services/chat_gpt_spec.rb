require "rails_helper"
RSpec.describe ChatGptService do
  describe ".analyze" do
    it "returns an answer for the message in the request body", :vcr do
      message = "Hello"
      result = ChatGptService.analyze(message)

      expect(result).to eq("Hello! How can I assist you today?")
    end
  end
end
