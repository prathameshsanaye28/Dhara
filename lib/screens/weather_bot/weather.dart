import 'dart:convert';

import 'package:flutter/material.dart';

Future<Map<String, dynamic>> getWeatherAdvisory(String city) async {
  var url = Uri.parse('https://0796-2401-4900-33ba-364-d958-5240-ea26-c661.ngrok-free.app/weather_advisory');
  var http;
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'city': city}),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to get weather advisory');
  }
}



class ApiTestPage extends StatefulWidget {
  @override
  _ApiTestPageState createState() => _ApiTestPageState();
}

class _ApiTestPageState extends State<ApiTestPage> {
  String _result = "";

  void _testWeatherApi() async {
    try {
      var result = await getWeatherAdvisory("Dhanbad");
      setState(() {
        _result = result.toString();
      });
    } catch (e) {
      setState(() {
        _result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("API Test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _testWeatherApi,
              child: Text("Test Weather API"),
            ),
            SizedBox(height: 16),
            Text("Result: $_result"),
          ],
        ),
      ),
    );
  }
}