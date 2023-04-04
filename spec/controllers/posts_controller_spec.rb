require 'rails_helper'

RSpec.describe '/posts', type: :request do
  describe 'GET /index' do
    before(:example) do
      get '/users/1/posts'
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'renders the correct body content' do
      expect(response.body).to include('Hello, This is posts')
    end
  end
end
