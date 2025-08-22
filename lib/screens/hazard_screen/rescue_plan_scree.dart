import 'package:dhara_sih/widgets/custom_green_button.dart';
import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RescuePlanScreen extends StatelessWidget {
  const RescuePlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Icon(Icons.warning,color: Colors.red,),
          SizedBox(width: 20,),
          CircleAvatar(
            backgroundImage: NetworkImage("https://plus.unsplash.com/premium_photo-1674489157120-9c386f7173d9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
          ),
          SizedBox(width: 20,),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            const RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
            SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text("Rescue Plan for Gas Leak", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),),
                      SizedBox(height: 10,),
                      GlassEffectContainer(width: double.infinity, height: 400, borderRadius: 25, 
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Location: ",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                                Text("Ventilation Tunnel",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                              ],
                            ),
                            SizedBox(height: 25,),
                            Text("Immediate Actions: ",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                                Text("Evacuate immediately",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                                Text("Ventilate area",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                                Text("Seal Leaks",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                                SizedBox(height: 25,),
                                Text("Equipments Required: ",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                                ),),
                                Text("Gas Masks",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                                Text("Ventilation Equipment",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),),
                          ],
                        ),
                      )
                      ),
                      SizedBox(height: 30,),
                      
                    ],
                  ),
                ),
              ),
          ],
        ),
      )
    );
  }
}