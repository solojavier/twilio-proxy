require 'sinatra'

get '/' do
  'OK'
end

post '/call' do
  number = ENV['DIAL_PHONE']

  """<?xml version='1.0' encoding='UTF-8'?>
  <Response>
    <Dial><Number>#{number}</Number></Dial>
  </Response>
  """
end
