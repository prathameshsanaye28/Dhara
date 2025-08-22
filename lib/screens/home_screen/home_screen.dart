import 'package:dhara_sih/models/shiftIncharge.dart';
import 'package:dhara_sih/resources/user_provider.dart';
import 'package:dhara_sih/reusable_widgets/gradient_button.dart';
import 'package:dhara_sih/reusable_widgets/quick_action_button.dart';
import 'package:dhara_sih/reusable_widgets/reusable_glassmorphic_container.dart';
import 'package:dhara_sih/reusable_widgets/reusable_scaffold.dart';
import 'package:dhara_sih/screens/checklist_screen/all_checklists.dart';
import 'package:dhara_sih/screens/daily_shift_log_screen/daily_shift_log_screen.dart';
import 'package:dhara_sih/screens/daily_shift_log_screen/log_book.dart';
import 'package:dhara_sih/screens/equipment.dart';
import 'package:dhara_sih/screens/equipment_screen.dart';
import 'package:dhara_sih/screens/hazard_screen/report_hazard.dart';
import 'package:dhara_sih/screens/pdf_summarizer/ocr_to_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../reusable_widgets/custom_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ShiftIncharge? user = Provider.of<UserProvider>(context).getUser;
    return ReusableScaffold(
      showBars: true,
      body: Center(
        child: GlassEffectContainer(
          width: double.infinity,
          height: 730,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(),
                    SizedBox(width: 8),
                    Text(
                      "Welcome, ${user?.name??''}!",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Quick Actions",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.white, // This will be replaced by the gradient
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QuickActionButton(
                    labelLine1: "Daily",
                    labelLine2: "Shift Log",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LogBookScreen()),
                      );
                    },
                    iconPath: 'assets/Icons/dailyshiftlog.png',
                  ),
                  QuickActionButton(
                    labelLine1: "Safety",
                    labelLine2: "Checklist",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllChecklistsScreen()));
                    },
                    iconPath: 'assets/Icons/safetychecklist.png',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QuickActionButton(
                    labelLine1: "Report",
                    labelLine2: "Hazard",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ReportHazardScreen()));
                    },
                    iconPath: 'assets/Icons/reporthazard.png',
                  ),
                  QuickActionButton(
                    labelLine1: "Equipment",
                    labelLine2: "Status",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EquipmentListScreen()));
                    },
                    iconPath: 'assets/Icons/equipmentstatus.png',
                  ),
                ],
              ),
              CustomContainer(
                width: 320,
                height: 95,
                verticalPadding: 8,
                horizontalPadding: 16,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/Icons/aichecklist.png',
                      width: 40,
                    ),
                    SizedBox(width: 16),
                    Align(
                      alignment: Alignment.centerLeft, // Align to the left
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align text to the start (left)
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFFD36BE5), // Start color
                                  Color(0xFFE166CC), // Second color
                                  Color.fromRGBO(
                                      223, 223, 223, 0.78), // Third color
                                  Color(0xFF881095), // End color
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(Rect.fromLTWH(
                                  0, 0, bounds.width, bounds.height));
                            },
                            child: const Text(
                              "Create Checklist with AI",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .white, // This will be replaced by the gradient
                              ),
                            ),
                          ),
                          //SizedBox(height: 4),
                          const Text(
                            "Smarter Checklists, Safer Workplaces",
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors
                                  .white, // This will be replaced by the gradient
                            ),
                          ),
                          SizedBox(height: 8),
                          GradientButton(
                            label: "Start Now",
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AllChecklistsScreen()));
                            },
                            width: 80,
                            height: 24,
                            fontSize: 12,
                            borderRadius: 4,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomContainer(
                width: 320,
                height: 95,
                verticalPadding: 8,
                horizontalPadding: 16,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/Icons/shiftlogsummariser.png',
                      width: 40,
                    ),
                    SizedBox(width: 16),
                    Align(
                      alignment: Alignment.centerLeft, // Align to the left
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align text to the start (left)
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                colors: [
                                  Color(0xFFD36BE5), // Start color
                                  Color(0xFFE166CC), // Second color
                                  Color.fromRGBO(
                                      223, 223, 223, 0.78), // Third color
                                  Color(0xFF881095), // End color
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(Rect.fromLTWH(
                                  0, 0, bounds.width, bounds.height));
                            },
                            child: const Text(
                              "Shift Log Summarizer",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .white, // This will be replaced by the gradient
                              ),
                            ),
                          ),
                          // SizedBox(height: 4),
                          const Text(
                            "Streamlining Shift Reports for Safer Mines",
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors
                                  .white, // This will be replaced by the gradient
                            ),
                          ),
                          SizedBox(height: 8),
                          GradientButton(
                            label: "Start Now",
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SummarizerScreen()));
                            },
                            width: 80,
                            height: 24,
                            fontSize: 12,
                            borderRadius: 4,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Spacer(),
              const Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 4, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Today's Insights",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.white, // This will be replaced by the gradient
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomContainer(
                        width: 160,
                        height: 80,
                        verticalPadding: 12,
                        horizontalPadding: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Total Hours Logged",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors
                                        .white, // This will be replaced by the gradient
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "10 hrs",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .white, // This will be replaced by the gradient
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      CustomContainer(
                        width: 160,
                        height: 80,
                        verticalPadding: 12,
                        horizontalPadding: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Safety Alerts",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors
                                        .white, // This will be replaced by the gradient
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .white, // This will be replaced by the gradient
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomContainer(
                        width: 160,
                        height: 80,
                        verticalPadding: 12,
                        horizontalPadding: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Safety Incidents",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors
                                        .white, // This will be replaced by the gradient
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .white, // This will be replaced by the gradient
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      CustomContainer(
                        width: 160,
                        height: 80,
                        verticalPadding: 12,
                        horizontalPadding: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Equipments in Use",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors
                                        .white, // This will be replaced by the gradient
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "8/10",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors
                                        .white, // This will be replaced by the gradient
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
