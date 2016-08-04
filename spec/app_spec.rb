require 'spec_helper'
require 'rspec'
require 'rack/test'

require_relative '../app.rb'

RSpec.describe 'Twilio Proxy App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe 'call forwarding' do
    let(:number) { '+523333505050' }

    before do
      ENV['PHONE_NUMBER'] = number

      post '/call'
    end

    it 'uses twiml to dial configured number' do
      expected_response =
        "  <Response>\n" \
        "    <Dial><Number>#{number}</Number></Dial>\n" \
        '  </Response>'

      expect(last_response.body).to include(expected_response)
    end
  end

  describe 'sms forwarding' do
    let(:from) { '+1347234567' }
    let(:number) { '+523333505050' }
    let(:body)    { 'Hello world' }
    let(:message) { "#{from} > #{body}" }

    before do
      ENV['SMS_NUMBER'] = number

      post '/sms', 'From' => from, 'Body' => body
    end

    it 'redirects message with correct message' do
      expected_response =
        "  <Response>\n" \
        "    <Sms to=\"#{number}\">#{message}</Sms>\n" \
        '  </Response>'

      expect(last_response.body).to include(expected_response)
    end
  end

  describe 'sms sending' do
    let(:number) { '+523333505050' }
    let(:to)      { '+134720392'  }
    let(:message) { 'Hello world' }
    let(:body)    { "#{to} #{message}" }

    before do
      ENV['SMS_NUMBER'] = number

      post '/sms', 'From' => number, 'Body' => body
    end

    it 'Sends sms to selected number' do
      expected_response =
        "  <Response>\n" \
        "    <Sms to=\"#{to}\">#{message}</Sms>\n" \
        '  </Response>'

      expect(last_response.body).to include(expected_response)
    end
  end
end
