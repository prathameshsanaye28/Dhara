import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;

import '../models/shift_log.dart';

Future<Uint8List> generatePdf(ShiftLog shiftLog) async {
  final pdf = pw.Document();

  final font =
      pw.Font.ttf(await rootBundle.load('assets/Fonts/Roboto-Regular.ttf'));
  final boldFont =
      pw.Font.ttf(await rootBundle.load('assets/Fonts/Roboto-Bold.ttf'));

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Shift Log',
                style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    font: boldFont)),
            pw.SizedBox(height: 16),
            pw.Text('Shift Date: ${shiftLog.shiftDate}',
                style: pw.TextStyle(font: font)),
            pw.Text('Shift Time: ${shiftLog.shiftTime}',
                style: pw.TextStyle(font: font)),
            pw.Text('Area/Section: ${shiftLog.areaSection}',
                style: pw.TextStyle(font: font)),
            pw.Text('Bolts Tested: ${shiftLog.boltsTested}',
                style: pw.TextStyle(font: font)),
            pw.Text('Bolts Above Rating: ${shiftLog.boltsAboveRating}',
                style: pw.TextStyle(font: font)),
            pw.Text('Bolts Below Rating: ${shiftLog.boltsBelowRating}',
                style: pw.TextStyle(font: font)),
            pw.Text('Remarks: ${shiftLog.remarks}',
                style: pw.TextStyle(font: font)),
            pw.Text('Foreman Signature: ${shiftLog.foremanSignature}',
                style: pw.TextStyle(font: font)),
            pw.Text('Manager Signature: ${shiftLog.managerSignature}',
                style: pw.TextStyle(font: font)),
            pw.Text('Certificate Number: ${shiftLog.certificateNumber}',
                style: pw.TextStyle(font: font)),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
