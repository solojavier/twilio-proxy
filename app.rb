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
  number = ENV['SMS_PHONE']
  from   = params['From']
  words  = params['Body'].split

  if number == from
    number, *body_words = *words
    body = body_words.join(' ')
  else
    body   = "#{params['From']} > #{params['Body']}"
  end

  """<?xml version='1.0' encoding='UTF-8'?>
  <Response>
    <Sms to=\"#{number}\">#{body}</Sms>
  </Response>
  """
end
