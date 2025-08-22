import 'package:dhara_sih/widgets/custom_green_button.dart';
import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Icon(
              Icons.warning,
              color: Colors.red,
            ),
            SizedBox(
              width: 20,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://plus.unsplash.com/premium_photo-1674489157120-9c386f7173d9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: Stack(
          children: [
            const RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GlassEffectContainer(
                        width: double.infinity,
                        height: 400,
                        borderRadius: 25,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Active Alerts",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: 35,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              105, 103, 102, 102),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Alert Type",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 35,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              105, 103, 102, 102),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Severity",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 35,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              105, 103, 102, 102),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Location",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 35,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              105, 103, 102, 102),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Timestamp",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 35,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              105, 103, 102, 102),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Actions",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              _buildRowItem("High Methane", "Critical",
                                  "Section B", "12:35 PM"),
                              Divider(
                                color: Colors.white,
                                thickness: 0.25,
                              ),
                              SizedBox(height: 15,),
                              _buildRowItem("High Methane", "Warning",
                                  "Section B", "12:35 PM"),
                              Divider(
                                color: Colors.white,
                                thickness: 0.25,
                              ),
                              SizedBox(height: 15,),
                              _buildRowItem("High Methane", "Warning",
                                  "Section B", "12:35 PM"),
                              Divider(
                                color: Colors.white,
                                thickness: 0.25,
                              ),
                              SizedBox(height: 15,),
                              _buildRowItem("High Methane", "Critical",
                                  "Section B", "12:35 PM"),
                              Divider(
                                color: Colors.white,
                                thickness: 0.25,
                              ),
                              SizedBox(height: 15,),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

Widget _buildRowItem(
    String alertType, String severity, String location, String timestamp) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        alertType,
        style: TextStyle(color: Colors.white, fontSize: 13),
      ),
      Container(
        alignment: Alignment.center,
        width: 60,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: severity == "Critical"
                ? Colors.red
                : severity == "Warning"
                    ? Colors.orange
                    : Colors.green),
        child: Text(
          severity,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Text(
        location,
        style: TextStyle(color: Colors.white, fontSize: 13),
      ),
      Text(
        timestamp,
        style: TextStyle(color: Colors.white, fontSize: 13),
      ),
      Container(
        width: 75,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 82, 239),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Investigate",
          style: TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
