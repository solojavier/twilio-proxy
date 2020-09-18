# Twilio Proxy

This app serves as a proxy to have a virtual phone and redirect calls and SMS

## Setup

To deploy this app to heroku you need to setup an env variable:

 * SMS_NUMBER : Phone number to which you want SMS and calls to be forwarded (+52 format for mx)
 * PHONE_NUMBER : Phone number to which you want SMS and calls to be forwarded (+521 format for mx)

After you have the app deployed, you need to buy a twilio phone number
and then setup webhooks to you app endpoints '/call' and '/sms' accordingly


## How it works

* When you get a call to your virtual twilio number it is forwarded to PHONE_NUMBER
* When an SMS is received by your virtual twilio number it gets forwarded to SMS_NUMBER
* You can also send an SMS from you virtual twilio number by sendind an SMS from SMS_NUMBER and adding the receiver phone as the first word ("To:+523333505090 Hi")

## Want to use it?

* Open an issue for questions, bugs and stuff
