import 'package:dhara_sih/screens/hazard_screen/rescue_plan_scree.dart';
import 'package:dhara_sih/widgets/custom_green_button.dart';
import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RiskIndexScreen extends StatelessWidget {
  const RiskIndexScreen({super.key});
  final _needlepointervalue = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          Icon(Icons.warning,color: Colors.red,),
          SizedBox(width: 20,),
          CircleAvatar(
            backgroundImage: NetworkImage("https://plus.unsplash.com/premium_photo-1674489157120-9c386f7173d9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
          ),
          SizedBox(width: 20,),
        ],
        title: Text("Risk Meter",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const rive.RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  GlassEffectContainer(width: double.infinity, height: 500, borderRadius: 25, 
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(minimum: 0, maximum: 1,
                            axisLabelStyle: GaugeTextStyle(color: Colors.white),
                            radiusFactor: 0.6,
                          ranges: <GaugeRange>[
                            GaugeRange(startValue: 0, endValue: 0.33, color:Colors.green,),
                            GaugeRange(startValue: 0.33,endValue: 0.67,color: Colors.orange),
                            GaugeRange(startValue: 0.67,endValue: 1.0,color: Colors.red)],
                          pointers: <GaugePointer>[
                            NeedlePointer(value: _needlepointervalue) ////Value for the needle to move
                            ],
                          annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                          widget: Container(
                            child: Text(
                              'Low',
                              style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                            ),
                          ),
                          angle: 180, // Adjust to position near the green range
                          positionFactor: 1.3,
                        ),
                        // Annotation for Medium
                        GaugeAnnotation(
                          widget: Container(
                            child: Text(
                              'Medium',
                              style: TextStyle(fontSize: 16, color: Colors.orange, fontWeight: FontWeight.bold),
                            ),
                          ),
                          angle: 270, // Adjust to position near the orange range
                          positionFactor: 1.3,
                        ),
                        // Annotation for High
                        GaugeAnnotation(
                          widget: Container(
                            child: Text(
                              'High',
                              style: TextStyle(fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ),
                          angle: 0, // Adjust to position near the red range
                          positionFactor: 1.3,
                        ),
                            GaugeAnnotation(widget: Container(child: 
                                Text('Risk',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white))),
                                angle: 90, positionFactor: 0.5
                                  )]
                            )],
                          enableLoadingAnimation: true,
                                  
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Hazard: ",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),),
                            Text("Gas Leak",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),)
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Location: ",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            ),),
                            Text("Ventilation Tunnel",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16
                            ),)
                          ],
                        ),
                        SizedBox(height: 20,),
                        _buildRiskLabel(_needlepointervalue),
                      ],
                    ),
                  )),
                  SizedBox(height: 10,),
                 _needlepointervalue >= 0.75
    ? Image.asset(
        'assets/Icons/evac.jpeg',
        width: double.infinity, // Full width of the screen
// Full height of the screen
        fit: BoxFit.cover, // Ensures the image covers the entire area
      )
    : SizedBox(height: 1), SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RescuePlanScreen()));
                    },
                    child: CustomGreenButton(label: "Generate Rescue Plan"))
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}

   Widget _buildRiskLabel(double _needlepointervalue) {
    String riskText = _needlepointervalue <= 0.33
        ? 'Low'
        : _needlepointervalue <= 0.67
            ? 'Medium'
            : 'High';
    return Container(
      height: 40,
      width: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: _needlepointervalue <= 0.33
        ? Colors.green
        : _needlepointervalue <= 0.67
            ? Colors.orange
            : Colors.red
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("$riskText Risk", style:TextStyle(color: Colors.white,
        fontSize: 16),),
      ),
    );
  }






