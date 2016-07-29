class ResponseBuilder
  def initialize
    @number = ENV['NUMBER']
  end

  def for_dial
    dial_response(@number)
  end

  def for_sms(from, body)
    if @number == from
      sms_response(body.match(' ').pre_match, body.match(' ').post_match)
    else
      sms_response(@number, "#{from} > #{body}")
    end
  end

  private

  def dial_response(number)
    ''"<?xml version='1.0' encoding='UTF-8'?>
  <Response>
    <Dial><Number>#{number}</Number></Dial>
  </Response>
    "''
  end

  def sms_response(to, message)
    ''"<?xml version='1.0' encoding='UTF-8'?>
  <Response>
    <Sms to=\"#{to}\">#{message}</Sms>
  </Response>
    "''
  end
end
