class ResponseBuilder
  def initialize
    @phone_number = ENV['PHONE_NUMBER']
  end

  def for_dial
    dial_response(@phone_number)
  end

  def for_sms(from, body)
    if @phone_number == from
      sms_response(body.match(' ').pre_match, body.match(' ').post_match)
    else
      sms_response(@phone_number, "#{from} > #{@phone_number}: #{body}")
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
