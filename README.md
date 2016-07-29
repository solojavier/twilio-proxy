# Twilio Proxy

This app serves as a proxy to have a virtual phone and redirect calls and SMS

## Setup

To deploy this app to heroku you need to setup an env variable:

 * NUMBER : Phone number to which you want SMS and calls to be forwarded

After you have the app deployed, you need to buy a twilio phone number
and then setup webhooks to you app endpoints '/call' and '/sms' accordingly


## How it works

* When you get a call to your virtual twilio number it is forwarded to NUMBER
* When an SMS is received by your virtual twilio number it gets forwarded to NUMBER
* You can also send an SMS from you virtual twilio number by sendind an SMS from NUMBER and adding the receiver phone as the first word ("+5213333505090 Hi")

## Want to use it?

* Open an issue for questions, bugs and stuff
