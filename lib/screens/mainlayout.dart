
import 'package:dhara_sih/screens/checklist_screen/all_checklists.dart';
import 'package:dhara_sih/screens/checklist_screen/image_to_text.dart';
import 'package:dhara_sih/screens/checklist_screen/imagetotext_marathi.dart';
import 'package:dhara_sih/screens/checklist_screen/mar_to_eng.dart';
import 'package:dhara_sih/screens/equipment.dart';
import 'package:dhara_sih/screens/hazard_screen/report_hazard.dart';
import 'package:dhara_sih/screens/iot_screens/iot_dashboard.dart';
import 'package:dhara_sih/screens/pdf_summarizer/ocr_to_summary.dart';
import 'package:dhara_sih/screens/pdf_summarizer/select_reports.dart';
import 'package:dhara_sih/screens/sos/call_screen.dart';
import 'package:dhara_sih/screens/weather_bot/weather.dart';
import 'package:dhara_sih/screens/weather_bot/weather_bot.dart';
import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MainlayoutScreen extends StatelessWidget {
  const MainlayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Main Layout",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
          SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportHazardScreen()));
          }, child: Text("Hazard Screen")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectReportsScreen()));
          }, child: Text("PDF summarizer")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherBotScreen()));
          }, child: Text("Weather Bot")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>IotDashboardScreen()));
          }, child: Text("Iot screen")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CallScreen()));
          }, child: Text("Call screen")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AllChecklistsScreen()));
          }, child: Text("Checklist screen")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageToTextMarathiScreen()));
          }, child: Text("Checklist screen marathi")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>TranslationPage()));
          }, child: Text("Translation screen marathi")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SummarizerScreen()));
          }, child: Text("summarize")),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ApiTestPage()));
          }, child: Text("Weather")),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}


// Scaffold(
//       backgroundColor: Colors.black,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //     title: Text("Hazard Detection and Rescue Plan", style: TextStyle(
      //                 fontSize: 20,
      //                 fontWeight: FontWeight.bold,
      //                 color: Colors.white
      //               ),),
      //   elevation: 0,
      //   actions: [
      //     Icon(Icons.warning,color: Colors.red,),
//           SizedBox(width: 20,),
//           CircleAvatar(
//             backgroundImage: NetworkImage("https://plus.unsplash.com/premium_photo-1674489157120-9c386f7173d9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
//           ),
//           SizedBox(width: 20,),
//         ],
//       ),
//       body:Stack(
//         children: [
//           const RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
//           SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   children: [
//                     Text("Hazard Detection and Rescue Plan", style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white
//                     ),),
//                     SizedBox(height: 10,),
//                     GlassEffectContainer(width: double.infinity, height: 400, borderRadius: 25, 
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
                          
//                         ],
//                       ),
//                     )
//                     ),
//                     SizedBox(height: 30,),
//                     GestureDetector(
//                       onTap: (){
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>RiskIndexScreen()));
//                       },
//                       child: CustomGreenButton(label: 'Analyze Risk'))
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       )
//     );