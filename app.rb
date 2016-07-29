require 'sinatra'

post '/call' do
  dial
end

post '/sms' do
  sms(params['From'], params['Body'])
end

def dial(number = ENV['DIAL_PHONE'])
  build_response("<Dial><Number>#{number}</Number></Dial>")
end

def sms(from, body, number = ENV['SMS_PHONE'])
  if number == from
    send_sms(body.match(' ').pre_match, body.match(' ').post_match)
  else
    send_sms(number, "#{from} > #{body}")
  end
end

def send_sms(to, message)
  build_response("<Sms to=\"#{to}\">#{message}</Sms>")
end

def build_response(command)
  ''"<?xml version='1.0' encoding='UTF-8'?>
  <Response>
    #{command}
  </Response>
  "''
end
