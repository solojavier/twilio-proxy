require 'sinatra'

post '/call' do
  Response.new.call
end

post '/sms' do
  Response.new.sms(params['From'], params['Body'])
end

class Response
  def call
    build_response("<Dial><Number>#{ENV['PHONE']}</Number></Dial>")
  end

  def sms(from, body, number = ENV['PHONE'])
    if number == from
      send_sms(body.match(' ').pre_match, body.match(' ').post_match)
    else
      send_sms(number, "#{from} > #{body}")
    end
  end

  private

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
end
