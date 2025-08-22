import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:csv/csv.dart';
import 'package:dhara_sih/reusable_widgets/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../reusable_widgets/custom_container.dart';
import '../../reusable_widgets/custom_dropdown.dart';
import '../../reusable_widgets/gradient_button.dart';
import '../../reusable_widgets/reusable_glassmorphic_container.dart';
import '../../reusable_widgets/reusable_scaffold.dart';

class DynamicDailyShiftLogScreen extends StatefulWidget {
  const DynamicDailyShiftLogScreen({super.key});

  @override
  State<DynamicDailyShiftLogScreen> createState() =>
      _DynamicDailyShiftLogScreenState();
}

class _DynamicDailyShiftLogScreenState
    extends State<DynamicDailyShiftLogScreen> {
  final Map<String, TextEditingController> _controllers = {};
  final List<Map<String, String>> _fields = [];
  String? _selectedShiftTime;
  String? _selectedForemanSignature;
  String? _selectedManagerSignature;

  @override
  void initState() {
    super.initState();
    _loadFieldsFromCSV();
  }

  Future<void> _loadFieldsFromCSV() async {
    final input = await rootBundle.loadString('assets/response.csv');
    final fields = const CsvToListConverter().convert(input, eol: '\n');
    setState(() {
      for (var field in fields) {
        if (field.length >= 3) {
          _fields.add({
            'title': field[0].toString(),
            'type': field[1].toString(),
            'label': field[2].toString(),
          });
          _controllers[field[0].toString()] = TextEditingController();
        }
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _saveShiftLog() async {
    try {
      final shiftLog = <String, dynamic>{};
      for (var field in _fields) {
        final title = field['title']!;
        final type = field['type']!;
        final controller = _controllers[title]!;
        if (type == 'int') {
          shiftLog[title] = int.tryParse(controller.text) ?? 0;
        } else {
          shiftLog[title] = controller.text;
        }
      }
      shiftLog['shiftTime'] = _selectedShiftTime ?? "";
      shiftLog['foremanSignature'] = _selectedForemanSignature ?? "";
      shiftLog['managerSignature'] = _selectedManagerSignature ?? "";

      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        await FirebaseFirestore.instance
            .collection('dynamicShiftLogs')
            .add(shiftLog);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Shift Log Saved and Uploaded Successfully')),
        );
      } else {
        final dynamicShiftLogBox = await Hive.openBox('dynamicShiftLogBox');
        dynamicShiftLogBox.add(shiftLog);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('No internet connection. Shift Log saved locally.')),
        );
      }
    } catch (e) {
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
              height: 5500,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var field in _fields)
                      _buildStaticField(field['title']!,
                          _controllers[field['title']]!, field['label']!),
                    _buildDropdownField("Shift Time", _selectedShiftTime,
                        ["Morning", "Evening"], (value) {
                      setState(() {
                        _selectedShiftTime = value;
                      });
                    }),
                    _buildDropdownField(
                        "Foreman Signature",
                        _selectedForemanSignature,
                        ["Signed", "Not Signed"], (value) {
                      setState(() {
                        _selectedForemanSignature = value;
                      });
                    }),
                    _buildDropdownField(
                        "Manager Signature",
                        _selectedManagerSignature,
                        ["Signed", "Not Signed"], (value) {
                      setState(() {
                        _selectedManagerSignature = value;
                      });
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GradientButton(
                          label: "Save",
                          onPressed: () async {
                            await _saveShiftLog();
                          },
                          width: 120,
                          height: 45,
                          fontSize: 16,
                        ),
                        GradientButton(
                          label: "View PDF",
                          onPressed: () async {
                            final shiftLog = <String, dynamic>{};
                            for (var field in _fields) {
                              final title = field['title']!;
                              final type = field['type']!;
                              final controller = _controllers[title]!;
                              if (type == 'int') {
                                shiftLog[title] =
                                    int.tryParse(controller.text) ?? 0;
                              } else {
                                shiftLog[title] = controller.text;
                              }
                            }
                            shiftLog['shiftTime'] = _selectedShiftTime ?? "";
                            shiftLog['foremanSignature'] =
                                _selectedForemanSignature ?? "";
                            shiftLog['managerSignature'] =
                                _selectedManagerSignature ?? "";

                            _viewPdf(shiftLog);
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

  void _viewPdf(Map<String, dynamic> shiftLog) {
  final pdf = pw.Document();

  // Split shift log entries into chunks for pages
  final entriesPerPage = 15; // Number of entries per page
  final entries = shiftLog.entries.toList();

  for (int i = 0; i < entries.length; i += entriesPerPage) {
    final pageEntries = entries.skip(i).take(entriesPerPage);

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Dynamic Shift Log', style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 16),
              for (var entry in pageEntries)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('${entry.key}:', style: pw.TextStyle(fontSize: 18)),
                    pw.Text(entry.value.toString(),
                        style: pw.TextStyle(fontSize: 14)),
                    pw.SizedBox(height: 8),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }

  // Display the PDF
  Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}

  Widget _buildStaticField(
      String title, TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(height: 8),
        ReusableTextField(label: label, controller: controller,),
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
