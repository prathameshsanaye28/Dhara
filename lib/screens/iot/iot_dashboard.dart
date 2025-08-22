//import 'package:dhara_sih/screens/iot_screens/alerts_screen.dart';
//import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
import 'package:dhara_sih/reusable_widgets/reusable_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../reusable_widgets/reusable_glassmorphic_container.dart';
import 'alerts_screen.dart';

class IotDashboardScreen extends StatelessWidget {
  const IotDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
      showBars: true,
      body: GlassEffectContainer(
        width: double.infinity,
        height: 675,
        //borderRadius: 25,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "IOT Monitoring Dashboard",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color.fromARGB(255, 66, 163, 69),
                        const Color.fromARGB(255, 66, 163, 69),
                        const Color.fromARGB(255, 66, 163, 69),
                        const Color.fromARGB(255, 43, 118, 46),
                        const Color.fromARGB(255, 29, 83, 31),
                        const Color.fromARGB(255, 20, 57, 21),
                      ]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.sensors,
                            color: const Color.fromARGB(255, 16, 70, 17)),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          "Overview",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlertsScreen()));
                    },
                    child: Container(
                      height: 40,
                      width: 160,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color.fromARGB(255, 66, 163, 69),
                          const Color.fromARGB(255, 66, 163, 69),
                          const Color.fromARGB(255, 66, 163, 69),
                          const Color.fromARGB(255, 43, 118, 46),
                          const Color.fromARGB(255, 29, 83, 31),
                          const Color.fromARGB(255, 20, 57, 21),
                        ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning,
                              color: const Color.fromARGB(255, 16, 70, 17)),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Alerts",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(105, 103, 102, 102)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                _showSafetyDialog(context);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 230, 159, 7),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "Safety Warnings",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      //SizedBox(height:2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.thermostat, color: Colors.red),
                          SizedBox(width: 5),
                          Text(
                            'Temperature',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [Colors.purple, Colors.red, Colors.grey],
                            stops: [0.0, 0.5, 1.0],
                          ).createShader(bounds);
                        },
                        child: SfLinearGauge(
                          axisTrackStyle: LinearAxisTrackStyle(
                            thickness: 15,
                            edgeStyle: LinearEdgeStyle.bothCurve,
                            color: Colors
                                .grey.shade800, // Background for empty part
                          ),
                          barPointers: [
                            LinearBarPointer(
                              value: 32,
                              thickness: 15,
                              edgeStyle: LinearEdgeStyle.bothCurve,
                              color: Colors.white, // Filled gradient area
                            ),
                          ],
                          showLabels: false,
                          showTicks: false,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Temperature value display
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Temperature: 32°C',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 230, 159, 7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Moderate Temperature: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Monitor Conditions closely",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(105, 103, 102, 102)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.cloud_outlined, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(
                            'Gas Levels',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Methane(CH4):",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              _buildLevels(1.4)
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Carbon Dioxide(CO2):",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                              _buildLevels(0.9)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 230, 159, 7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Caution: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Gas levels rising, monitor closely",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(105, 103, 102, 102)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.battery_0_bar_outlined,
                              color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Sensor Health',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Total Sensors",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "42",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Active",
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "39",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Inactive",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "3",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSafetyDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Close dialog when tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.thermostat, color: Colors.red),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Safety Warnings",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.close, color: Colors.black),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Low Temperature Warning
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle, color: Colors.red, size: 8),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "Low Temperature (<20°C): ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                        children: [
                          TextSpan(
                            text:
                                "Increased humidity risks slippery surfaces. Ensure proper ventilation.",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Moderate Temperature Warning
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle, color: Colors.red, size: 8),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "Moderate Temperature (20–35°C): ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                        children: [
                          TextSpan(
                            text:
                                "Normal, but monitor conditions closely. Prolonged exposure may cause heat stress.",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // High Temperature Warning
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.circle, color: Colors.red, size: 8),
                  SizedBox(width: 8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: "High Temperature (>35°C): ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                        children: [
                          TextSpan(
                            text:
                                "Risk of spontaneous coal combustion. Ensure immediate evacuation and improve ventilation.",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildLevels(double reading) {
  return Text(
    reading.toString() + " ppm",
    style: TextStyle(
        color: reading <= 1.0
            ? Colors.green
            : reading <= 1.5
                ? Colors.orange
                : Colors.red,
        fontSize: 18,
        fontWeight: FontWeight.bold),
  );
}
