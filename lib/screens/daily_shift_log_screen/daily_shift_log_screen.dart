import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dhara_sih/models/boxes.dart';
import 'package:dhara_sih/models/shift_log.dart';
import 'package:dhara_sih/reusable_widgets/custom_container.dart';
import 'package:dhara_sih/reusable_widgets/gradient_button.dart';
import 'package:dhara_sih/reusable_widgets/reusable_glassmorphic_container.dart';
import 'package:dhara_sih/reusable_widgets/reusable_scaffold.dart';
import 'package:dhara_sih/reusable_widgets/reusable_text_field.dart';
import 'package:flutter/material.dart';

import '../../reusable_widgets/custom_dropdown.dart';
import '../../services/view_pdf.dart';

class DailyShiftLogScreen extends StatefulWidget {
  const DailyShiftLogScreen({super.key});

  @override
  State<DailyShiftLogScreen> createState() => _DailyShiftLogScreenState();
}

class _DailyShiftLogScreenState extends State<DailyShiftLogScreen> {
  // Controllers for form fields
  final TextEditingController _shiftDateController = TextEditingController();
  final TextEditingController _areaSectionController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _boltsTestedController = TextEditingController();
  final TextEditingController _boltsAboveRatingController =
      TextEditingController();
  final TextEditingController _boltsBelowRatingController =
      TextEditingController();
  final TextEditingController _certificateNumberController =
      TextEditingController();

  String? _selectedShiftTime;
  String? _selectedForemanSignature;
  String? _selectedManagerSignature;

  @override
  void dispose() {
    _shiftDateController.dispose();
    _areaSectionController.dispose();
    _remarksController.dispose();
    _boltsTestedController.dispose();
    _boltsAboveRatingController.dispose();
    _boltsBelowRatingController.dispose();
    _certificateNumberController.dispose();
    super.dispose();
  }

  Future<void> _saveShiftLog() async {
    try {
      final shiftLog = ShiftLog(
        shiftDate: _shiftDateController.text,
        shiftTime: _selectedShiftTime ?? "",
        areaSection: _areaSectionController.text,
        boltsTested: int.tryParse(_boltsTestedController.text) ?? 0,
        boltsAboveRating: int.tryParse(_boltsAboveRatingController.text) ?? 0,
        boltsBelowRating: int.tryParse(_boltsBelowRatingController.text) ?? 0,
        remarks: _remarksController.text,
        foremanSignature: _selectedForemanSignature ?? "",
        managerSignature: _selectedManagerSignature ?? "",
        certificateNumber: _certificateNumberController.text,
      );

      // Check internet connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      print("Connectivity Result: $connectivityResult");
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        // Internet is available, upload to Firestore
        await FirebaseFirestore.instance
            .collection('shiftLogs')
            .add(shiftLog.toJson());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Shift Log Saved and Uploaded Successfully')),
        );
      } else {
        // No internet, save locally to Hive
        testBox.add(shiftLog);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('No internet connection. Shift Log saved locally.')),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
      showBars: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GlassEffectContainer(
              width: double.infinity,
              height: 1500,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shift Date Input
                    _buildStaticField("Shift Date", _shiftDateController),

                    // Area and Section Input
                    _buildStaticField("Area/Section", _areaSectionController),

                    // Remarks Input (large)
                    _buildStaticField("Remarks", _remarksController,
                        isLarge: true),

                    // Bolts Tested Input
                    _buildStaticField("Bolts Tested", _boltsTestedController),

                    // Bolts Above Rating Input
                    _buildStaticField(
                        "Bolts Above Rating", _boltsAboveRatingController),

                    // Bolts Below Rating Input
                    _buildStaticField(
                        "Bolts Below Rating", _boltsBelowRatingController),

                    // Certificate Number Input
                    _buildStaticField(
                        "Certificate Number", _certificateNumberController),

                    // Shift Time Dropdown
                    _buildDropdownField("Shift Time", _selectedShiftTime,
                        ["Morning", "Evening"], (value) {
                      setState(() {
                        _selectedShiftTime = value;
                      });
                    }),

                    // Foreman Signature Dropdown
                    _buildDropdownField(
                        "Foreman Signature",
                        _selectedForemanSignature,
                        ["Signed", "Not Signed"], (value) {
                      setState(() {
                        _selectedForemanSignature = value;
                      });
                    }),

                    // Manager Signature Dropdown
                    _buildDropdownField(
                        "Manager Signature",
                        _selectedManagerSignature,
                        ["Signed", "Not Signed"], (value) {
                      setState(() {
                        _selectedManagerSignature = value;
                      });
                    }),

                    // Save Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GradientButton(
                          label: "Save",
                          onPressed: () async {
                            try {
                              print("Button Pressed");
                              await _saveShiftLog();
                            } catch (e) {
                              print("Error: $e");
                            }
                          },
                          width: 120,
                          height: 45,
                          fontSize: 16,
                        ),
                        GradientButton(
                          label: "View PDF",
                          onPressed: () async {
                            final shiftLog = ShiftLog(
                              shiftDate: _shiftDateController.text,
                              shiftTime: _selectedShiftTime ?? "",
                              areaSection: _areaSectionController.text,
                              boltsTested:
                                  int.tryParse(_boltsTestedController.text) ??
                                      0,
                              boltsAboveRating: int.tryParse(
                                      _boltsAboveRatingController.text) ??
                                  0,
                              boltsBelowRating: int.tryParse(
                                      _boltsBelowRatingController.text) ??
                                  0,
                              remarks: _remarksController.text,
                              foremanSignature: _selectedForemanSignature ?? "",
                              managerSignature: _selectedManagerSignature ?? "",
                              certificateNumber:
                                  _certificateNumberController.text,
                            );

                            viewPdf(shiftLog);
                          },
                          width: 120,
                          height: 45,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticField(String title, TextEditingController controller,
      {bool isLarge = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 8),
        isLarge
            ? CustomContainer(
                width: double.infinity,
                height: 100,
                verticalPadding: 4,
                horizontalPadding: 8,
                child: TextField(
                  controller: controller,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Enter $title",
                    border: InputBorder.none,
                  ),
                ),
              )
            : ReusableTextField(
                controller: controller,
                label: "Enter $title",
              ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField(String title, String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 8),
        CustomDropdown(
          label: "Select $title",
          value: value,
          onChanged: onChanged,
          items: items,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
