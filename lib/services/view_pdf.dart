import 'package:dhara_sih/services/generate_pdf.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../models/shift_log.dart';

void viewPdf(ShiftLog shiftLog) async {
  try {
    final pdfData = await generatePdf(shiftLog);

    // Preview PDF
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
  } on MissingPluginException catch (e) {
    print("Error: $e");
  } on PlatformException catch (e) {
    print("Error: $e");
  }
}
