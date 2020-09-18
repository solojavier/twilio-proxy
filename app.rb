require 'sinatra'

require_relative 'response_builder'

post '/call' do
  ResponseBuilder.new.for_dial
end

post '/sms' do
  puts params['From'].class
  ResponseBuilder.new.for_sms(params['From'], params['Body'])
end
