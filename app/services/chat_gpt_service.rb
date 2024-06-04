class ChatGptService
  def self.analyze(message)
    conn = Faraday.new(url: "https://api.openai.com/v1/chat/completions")

    response = conn.post do |request|
      request.headers['Content-Type'] = 'application/json'
      request.headers['Authorization'] = "Bearer #{Rails.application.credentials[:OPENAI_API_KEY]}"
      request.body = {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "user", content: message }
        ],
        temperature: 0.3
      }.to_json
    end

    result = JSON.parse(response.body, symbolize_names: true)

    result[:choices].first[:message][:content]
  end
end
