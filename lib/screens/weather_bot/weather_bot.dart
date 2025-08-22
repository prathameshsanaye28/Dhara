// // import 'package:dhara_sih/widgets/custom_green_button.dart';
// // import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
// // import 'package:flutter/material.dart';
// // import 'package:rive/rive.dart';

// // class WeatherBotScreen extends StatelessWidget {
// //   const WeatherBotScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       appBar: AppBar(
// //         backgroundColor: Colors.transparent,
          
// //         elevation: 0,
// //         actions: [
// //           Icon(Icons.warning,color: Colors.red,),
// //           SizedBox(width: 20,),
// //           CircleAvatar(
// //             backgroundImage: NetworkImage("https://plus.unsplash.com/premium_photo-1674489157120-9c386f7173d9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
// //           ),
// //           SizedBox(width: 20,),
// //         ],
// //       ),
// //       body:Stack(
// //         children: [
// //           const RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
// //           SingleChildScrollView(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(10.0),
// //                 child: Column(
// //                   children: [
// //                     SizedBox(height: 10,),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.end,
// //                       children: [
// //                         Container(
// //                           alignment: Alignment.center,
// //                           width: 150,
// //                           height: 40,
// //                           decoration: BoxDecoration(
// //                             color: const Color.fromARGB(255, 240, 158, 152),
// //                             borderRadius: BorderRadius.circular(25)
// //                           ),
// //                           child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               Icon(Icons.warning, color: Colors.red,),
// //                               SizedBox(width: 5,),
// //                               Text("Weather Alert", style: TextStyle(
// //                                 fontWeight: FontWeight.bold,
// //                                 fontSize: 14
// //                               ),),
// //                             ],
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     SizedBox(height: 20,),
// //                     GlassEffectContainer(width: double.infinity, height: 450, borderRadius: 25, 
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Column(
// //                             crossAxisAlignment: CrossAxisAlignment.stretch,
// //                             children: [
// //                               Icon(Icons.cloud_outlined, color: Colors.white,size: 70,),
// //                           SizedBox(height: 5,),
// //                           Text("It's Cloudy Outside!", textAlign: TextAlign.center,style: TextStyle(
// //                             color: Colors.white,
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 18
// //                           ),),
// //                           Text("It's a great time to take a break and recharge", 
// //                           textAlign: TextAlign.center,
// //                           style: TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 14,
// //                           ),),
// //                             ],
// //                           ),
                          
// //                           SizedBox(height: 30,),
// //                           Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text("Safety Recommendations: ",style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 16,
// //                                   fontWeight: FontWeight.bold
// //                                 ),),
// //                                 Text("Evacuate immediately",style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 14,
// //                                 ),),
// //                                 Text("Ventilate area",style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 14,
// //                                 ),),
// //                                 Text("Seal Leaks",style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 14,
// //                                 ),),
// //                             ],
// //                           ),
// //                           SizedBox(height: 40,),
// //                           Container(
// //                             width: double.infinity,
// //                             height: 150,
// //                             decoration: BoxDecoration(
// //                               color: const Color.fromARGB(255, 233, 180, 176),
// //                               borderRadius: BorderRadius.circular(10)
// //                             ),
// //                             child: Padding(
// //                               padding: const EdgeInsets.all(8.0),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Text("Weather Alert:",
// //                                   style: TextStyle(
// //                                     color: const Color.fromARGB(255, 96, 28, 23),
// //                                     fontSize: 16,
// //                                     fontWeight: FontWeight.bold
// //                                   ),),
// //                                   SizedBox(height: 10,),
// //                                   Text("Current weather ...............",
// //                                   style: TextStyle(
// //                                     color: const Color.fromARGB(255, 96, 28, 23),
// //                                     fontSize: 14
// //                                   ),)
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                           ElevatedButton(onPressed: (){}, child: Text("Next"))
// //                         ],
// //                       ),
// //                     )
// //                     ),
// //                     SizedBox(height: 30,),
                    
// //                   ],
// //                 ),
// //               ),
// //             ),
// //         ],
// //       )
// //     );
// //   }
// // }



// import 'package:dhara_sih/widgets/custom_green_button.dart';
// import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class WeatherBotScreen extends StatefulWidget {
//   const WeatherBotScreen({super.key});

//   @override
//   _WeatherBotScreenState createState() => _WeatherBotScreenState();
// }

// class _WeatherBotScreenState extends State<WeatherBotScreen> {
//   final TextEditingController _cityController = TextEditingController();
  
//   // Weather data variables
//   String _weatherCondition = "Loading...";
//   String _weatherDescription = "Checking weather information";
//   List<String> _recommendations = [];
//   String _riskLevel = "Moderate Risk";
  
//   // Weather API method
//   Future<void> _fetchWeatherRecommendations() async {
//     if (_cityController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter a city name')),
//       );
//       return;
//     }

//     try {
//       final response = await http.post(
//         Uri.parse('https://7196-2402-3a80-42ba-8f9e-2468-ba73-437b-f5f.ngrok-free.app/weather_recommendation'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'city': _cityController.text}),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
        
//         setState(() {
//           _weatherCondition = data['weather_data']['main'] ?? 'Unknown';
//           _weatherDescription = data['weather_data']['description'] ?? 'No description';
//           _recommendations = List<String>.from(data['recommendations'] ?? []);
//           _riskLevel = data['risk_level'] ?? 'Moderate Risk';
//         });
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to fetch weather data')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   // Method to get weather icon
//   IconData _getWeatherIcon(String condition) {
//     switch (condition.toLowerCase()) {
//       case 'clear':
//         return Icons.wb_sunny;
//       case 'clouds':
//         return Icons.cloud;
//       case 'rain':
//         return Icons.water_drop;
//       case 'thunderstorm':
//         return Icons.flash_on;
//       case 'snow':
//         return Icons.ac_unit;
//       default:
//         return Icons.cloud_outlined;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           Icon(Icons.warning, color: Colors.red,),
//           SizedBox(width: 20,),
//           CircleAvatar(
//             backgroundImage: NetworkImage("https://plus.unsplash.com/premium_photo-1674489157120-9c386f7173d9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
//           ),
//           SizedBox(width: 20,),
//         ],
//       ),
//       body: Stack(
//         children: [
//           const RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//                   SizedBox(height: 10,),
//                   // City Input Row
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           controller: _cityController,
//                           decoration: InputDecoration(
//                             hintText: 'Enter City Name',
//                             filled: true,
//                             fillColor: Colors.white24,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10,),
//                       IconButton(
//                         icon: Icon(Icons.search, color: Colors.white),
//                         onPressed: _fetchWeatherRecommendations,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         alignment: Alignment.center,
//                         width: 150,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 240, 158, 152),
//                           borderRadius: BorderRadius.circular(25)
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.warning, color: Colors.red,),
//                             SizedBox(width: 5,),
//                             Text("Weather Alert", style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14
//                             ),),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20,),
//                   GlassEffectContainer(
//                     width: double.infinity, 
//                     height: 450, 
//                     borderRadius: 25, 
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Icon(
//                                 _getWeatherIcon(_weatherCondition), 
//                                 color: Colors.white,
//                                 size: 70,
//                               ),
//                               SizedBox(height: 5,),
//                               Text(
//                                 "It's ${_weatherCondition} Outside!", 
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18
//                                 ),
//                               ),
//                               Text(
//                                 _weatherDescription, 
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
                          
//                           SizedBox(height: 30,),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Safety Recommendations: ",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold
//                                 ),
//                               ),
//                               // Dynamic recommendations
//                               ..._recommendations.map((recommendation) => 
//                                 Text(
//                                   recommendation,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 14,
//                                   ),
//                                 )
//                               ).toList(),
//                             ],
//                           ),
//                           SizedBox(height: 40,),
//                           Container(
//                             width: double.infinity,
//                             height: 150,
//                             decoration: BoxDecoration(
//                               color: const Color.fromARGB(255, 233, 180, 176),
//                               borderRadius: BorderRadius.circular(10)
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Weather Alert:",
//                                     style: TextStyle(
//                                       color: const Color.fromARGB(255, 96, 28, 23),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                   SizedBox(height: 10,),
//                                   Text(
//                                     "Risk Level: $_riskLevel",
//                                     style: TextStyle(
//                                       color: const Color.fromARGB(255, 96, 28, 23),
//                                       fontSize: 14
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     )
//                   ),
//                   SizedBox(height: 30,),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       )
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherBotScreen extends StatefulWidget {
  const WeatherBotScreen({super.key});

  @override
  _WeatherBotScreenState createState() => _WeatherBotScreenState();
}

class _WeatherBotScreenState extends State<WeatherBotScreen> {
  final TextEditingController _cityController = TextEditingController();
  
  // Weather data variables
  String _weatherCondition = "Loading...";
  String _weatherDescription = "Enter a city to get weather information";
  List<String> _recommendations = [];
  String _riskLevel = "Moderate Risk";
  double _temperature = 0.0;
  int _humidity = 0;
  double _windSpeed = 0.0;
  
  // OpenWeatherMap API Configuration
  static const String _apiKey = 'ade4f6dd653b564ecb0149acb66f0ac1'; // Replace with your actual API key

  // Method to fetch weather recommendations directly from OpenWeatherMap
  Future<void> _fetchWeatherRecommendations() async {
    if (_cityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a city name')),
      );
      return;
    }

    final city = _cityController.text;
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        // Extract weather details
        final weatherMain = data['weather'][0]['main'];
        final weatherDescription = data['weather'][0]['description'];
        
        setState(() {
          _weatherCondition = weatherMain;
          _weatherDescription = weatherDescription;
          _temperature = data['main']['temp'];
          _humidity = data['main']['humidity'];
          _windSpeed = data['wind']['speed'];
          
          // Generate recommendations based on weather conditions
          _recommendations = _getRecommendations(weatherMain);
          _riskLevel = _assessRiskLevel(weatherMain, _temperature, _windSpeed);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch weather data')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // Comprehensive recommendations based on weather conditions
  List<String> _getRecommendations(String condition) {
    final recommendations = {
      'Clear': [
        "Stay hydrated",
        "Use sunscreen",
        "Wear light clothing",
        "Avoid prolonged sun exposure"
      ],
      'Clouds': [
        "Carry an umbrella",
        "Keep electronic devices protected",
        "Be prepared for sudden rain"
      ],
      'Rain': [
        "Carry an umbrella",
        "Wear waterproof clothing",
        "Avoid waterlogged areas",
        "Drive carefully on wet roads"
      ],
      'Thunderstorm': [
        "Stay indoors",
        "Avoid open areas",
        "Unplug electronic devices",
        "Stay away from windows"
      ],
      'Snow': [
        "Wear warm layers",
        "Use proper footwear",
        "Drive cautiously",
        "Keep emergency supplies"
      ],
      'Mist': [
        "Reduce driving speed",
        "Use low beam headlights",
        "Maintain safe distance from other vehicles"
      ],
      'Fog': [
        "Avoid unnecessary travel",
        "Use fog lights",
        "Reduce speed and increase following distance"
      ]
    };

    return recommendations[condition] ?? ["Take standard precautions"];
  }

  // Advanced risk assessment based on multiple factors
  String _assessRiskLevel(String condition, double temperature, double windSpeed) {
    // Risk assessment matrix
    final riskLevels = {
      'Clear': _evaluateTemperatureRisk(temperature),
      'Clouds': _evaluateWindRisk(windSpeed),
      'Rain': 'Moderate to High Risk',
      'Thunderstorm': 'High Risk',
      'Snow': 'High Risk',
      'Mist': 'Moderate Risk',
      'Fog': 'High Risk'
    };

    return riskLevels[condition] ?? 'Moderate Risk';
  }

  // Temperature-based risk assessment
  static String _evaluateTemperatureRisk(double temperature) {
    if (temperature < 0) return 'Extreme Cold Risk';
    if (temperature < 10) return 'Low Risk - Cold';
    if (temperature > 35) return 'High Heat Risk';
    if (temperature > 25) return 'Moderate Heat Risk';
    return 'Low Risk';
  }

  // Wind-based risk assessment
  static String _evaluateWindRisk(double windSpeed) {
    if (windSpeed > 20) return 'High Wind Risk';
    if (windSpeed > 10) return 'Moderate Wind Risk';
    return 'Low Risk';
  }

  // Method to get weather icon
  IconData _getWeatherIcon(String condition) {
    final iconMap = {
      'Clear': Icons.wb_sunny,
      'Clouds': Icons.cloud,
      'Rain': Icons.water_drop,
      'Thunderstorm': Icons.flash_on,
      'Snow': Icons.ac_unit,
      'Mist': Icons.cloud_queue,
      'Fog': Icons.cloud_off
    };

    return iconMap[condition] ?? Icons.cloud_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const Icon(Icons.warning, color: Colors.red),
          const SizedBox(width: 20),
          CircleAvatar(
            backgroundImage: NetworkImage(
              "https://plus.unsplash.com/premium_photo-1674489157120-9c386f7173d9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Stack(
        children: [
          const RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            hintText: 'Enter City Name',
                            filled: true,
                            fillColor: const Color.fromARGB(191, 255, 255, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: _fetchWeatherRecommendations,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 240, 158, 152),
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.warning, color: Colors.red),
                            SizedBox(width: 5),
                            Text(
                              "Weather Alert", 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity, 
                    height: 450, 
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(
                                _getWeatherIcon(_weatherCondition), 
                                color: Colors.white,
                                size: 70,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "It's $_weatherCondition Outside!", 
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                              Text(
                                _weatherDescription, 
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Safety Recommendations: ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              ..._recommendations.map((recommendation) => 
                                Text(
                                  recommendation,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                )
                              ).toList(),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 233, 180, 176),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Weather Alert:",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 96, 28, 23),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Risk Level: $_riskLevel",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 96, 28, 23),
                                      fontSize: 14
                                    ),
                                  ),
                                  Text(
                                    "Temperature: $_temperature°C",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 96, 28, 23),
                                      fontSize: 14
                                    ),
                                  ),
                                  Text(
                                    "Humidity: $_humidity%",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 96, 28, 23),
                                      fontSize: 14
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}