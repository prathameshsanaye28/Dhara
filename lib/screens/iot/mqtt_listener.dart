import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhara_sih/screens/sos/sos_screen.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String mqttBroker = 'test.mosquitto.org';
  final int mqttPort = 1883;
  final String mqttClientId = 'flutter_mqtt_client';
  final String mqttTopic = 'esp32/mq2_alert';

  late MqttServerClient client;

  Future<void> initialize() async {
    client = MqttServerClient(mqttBroker, mqttClientId);

    client.port = mqttPort;
    client.logging(on: true);
    client.keepAlivePeriod = 20;

    try {
      await client.connect();
      print('Connected to MQTT broker');

      client.subscribe(mqttTopic, MqttQos.atMostOnce);

      client.updates!
          .listen((List<MqttReceivedMessage<MqttMessage?>>? messages) {
        final MqttPublishMessage recMessage =
            messages![0].payload as MqttPublishMessage;
        final String message = MqttPublishPayload.bytesToStringAsString(
            recMessage.payload.message);

        print('Received message: $message from topic: $mqttTopic');

        if (message == "Threshold exceeded") {
          // Trigger your desired Flutter service or Firebase action here
          print("Triggering service in Flutter...");
          initiateCall();
          //_storeAlertInFirestore();
        }
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  void _storeAlertInFirestore() async {
    final firestore = FirebaseFirestore.instance;
    await firestore.collection('alerts').add({
      'timestamp': DateTime.now().toIso8601String(),
      'alert': 'Threshold exceeded for 90 seconds',
    });
    print('Alert stored in Firestore');
  }
}

final TwilioService twilioService = TwilioService(
  accountSid: 'your_account_sid',
  authToken: 'your_auth_token',
);

void initiateCall() async {
  await twilioService.makeCall(
    to: '+917506547624', // The recipient's phone number
    from: '+17856209248', // Your Twilio phone number
    url:
        'https://handler.twilio.com/twiml/EH83be83e4747facf3a85789e34aaeee82', // TwiML Bin URL
  );
}
