class ResponseBuilder
  def initialize
    @phone_number = ENV['PHONE_NUMBER'].strip
  end

  def for_dial
    dial_response(@phone_number)
  end

  def for_sms(from, body)
    if body.start_with?('To:')
      to = body.match(' ').pre_match.gsub('To:', '')
      real_body = body.match(' ').post_match
      sms_response(to, real_body)
    else
      sms_response(@phone_number, "#{from} > #{body}")
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
    <Sms from="\#{@phone_number}\" to=\"#{to}\">#{message}</Sms>
  </Response>
    "''
  end
end
