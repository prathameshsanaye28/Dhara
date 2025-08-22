import 'package:dhara_sih/screens/sos/sos_screen.dart';
import 'package:flutter/material.dart';

class CallScreen extends StatelessWidget {
  final TwilioService twilioService = TwilioService(
    accountSid: 'your_account_sid',
    authToken: 'your_auth_token',
  );

  void initiateCall() async {
    await twilioService.makeCall(
      to: '+917506547624', // The recipient's phone number
      from: '+17856209248',  // Your Twilio phone number
      url: 'https://handler.twilio.com/twiml/EH83be83e4747facf3a85789e34aaeee82', // TwiML Bin URL
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twilio Call Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: initiateCall,
          child: Text('Make Call'),
        ),
      ),
    );
  }
}