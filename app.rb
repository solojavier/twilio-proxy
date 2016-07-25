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

post '/sms' do
  words = params['Body'].split

  if words.first == 'Send'
    _, number, *body = *words
  else
    number = ENV['SMS_PHONE']
    body   = "#{params['From']} > params['Body']"
  end

  """<?xml version='1.0' encoding='UTF-8'?>
  <Response>
    <Sms to=\"#{number}\">#{body}</Sms>
  </Response>
  """
end
