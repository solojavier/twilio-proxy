require 'sinatra'

post '/call' do
  number = ENV['DIAL_PHONE']

  build_response("<Dial><Number>#{number}</Number></Dial>")
end

post '/sms' do
  number = ENV['SMS_PHONE']
  from   = params['From']
  words  = params['Body'].split

  if number == from
    number, *body_words = *words
    body = body_words.join(' ')
  else
    body = "#{from} > #{params['Body']}"
  end

  build_response("<Sms to=\"#{number}\">#{body}</Sms>")
end

def build_response(command)
  ''"<?xml version='1.0' encoding='UTF-8'?>
  <Response>
    #{command}
  </Response>
  "''
end
