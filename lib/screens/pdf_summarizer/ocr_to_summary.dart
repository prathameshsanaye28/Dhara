// // // // // import 'dart:io';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:file_picker/file_picker.dart';
// // // // // import 'package:http/http.dart' as http;
// // // // // import 'package:http_parser/http_parser.dart';
// // // // // import 'dart:convert';


// // // // // class PDFSummarizerPage extends StatefulWidget {
// // // // //   @override
// // // // //   _PDFSummarizerPageState createState() => _PDFSummarizerPageState();
// // // // // }

// // // // // class _PDFSummarizerPageState extends State<PDFSummarizerPage> {
// // // // //   File? _selectedFile;
// // // // //   String _summarizedText = '';
// // // // //   bool _isLoading = false;
// // // // //   String _errorMessage = '';

// // // // //   Future<void> _pickPDFFile() async {
// // // // //     FilePickerResult? result = await FilePicker.platform.pickFiles(
// // // // //       type: FileType.custom,
// // // // //       allowedExtensions: ['pdf'],
// // // // //     );

// // // // //     if (result != null) {
// // // // //       setState(() {
// // // // //         _selectedFile = File(result.files.single.path!);
// // // // //       });
// // // // //     }
// // // // //   }

// // // // // //   Future<void> _pickPDFFile() async {
// // // // // //   try {
// // // // // //     FilePickerResult? result = await FilePicker.platform.pickFiles(
// // // // // //       type: FileType.custom,
// // // // // //       allowedExtensions: ['pdf'],
// // // // // //       allowMultiple: false,
// // // // // //     );

// // // // // //     if (result != null && result.files.isNotEmpty) {
// // // // // //       PlatformFile file = result.files.first;
      
// // // // // //       // Check if the file path is not null
// // // // // //       if (file.path != null) {
// // // // // //         setState(() {
// // // // // //           _selectedFile = File(file.path!);
// // // // // //           _summarizedText = '';
// // // // // //           _errorMessage = '';
// // // // // //         });
// // // // // //       } else {
// // // // // //         setState(() {
// // // // // //           _errorMessage = 'Unable to select file';
// // // // // //         });
// // // // // //       }
// // // // // //     }
// // // // // //   } catch (e) {
// // // // // //     setState(() {
// // // // // //       _errorMessage = 'Error selecting file: ${e.toString()}';
// // // // // //     });
// // // // // //   }
// // // // // // }

// // // // //   Future<void> _summarizePDF() async {
// // // // //     if (_selectedFile == null) {
// // // // //       setState(() {
// // // // //         _errorMessage = 'Please select a PDF file first';
// // // // //       });
// // // // //       return;
// // // // //     }

// // // // //     setState(() {
// // // // //       _isLoading = true;
// // // // //       _errorMessage = '';
// // // // //     });

// // // // //     try {
// // // // //       // Create multipart request
// // // // //       var request = http.MultipartRequest(
// // // // //         'POST', 
// // // // //         Uri.parse('https://e736-2402-3a80-42a2-69e5-a0a9-be3c-873b-475d.ngrok-free.app/summarizer/summarize')
// // // // //       );

// // // // //       // Add file to the request
// // // // //       request.files.add(
// // // // //         await http.MultipartFile.fromPath(
// // // // //           'files',
// // // // //           _selectedFile!.path,
// // // // //           contentType: MediaType('application', 'pdf')
// // // // //         )
// // // // //       );

// // // // //       // Add length parameters (optional)
// // // // //       request.fields['min_length'] = '100';
// // // // //       request.fields['max_length'] = '300';

// // // // //       // Send the request
// // // // //       var streamedResponse = await request.send();
// // // // //       var response = await http.Response.fromStream(streamedResponse);

// // // // //       // Parse the response
// // // // //       if (response.statusCode == 200) {
// // // // //         var jsonResponse = json.decode(response.body);
// // // // //         setState(() {
// // // // //           _summarizedText = jsonResponse['summary'];
// // // // //           _isLoading = false;
// // // // //         });
// // // // //       } else {
// // // // //         var jsonResponse = json.decode(response.body);
// // // // //         setState(() {
// // // // //           _errorMessage = jsonResponse['error'] ?? 'An error occurred';
// // // // //           _isLoading = false;
// // // // //         });
// // // // //       }
// // // // //     } catch (e) {
// // // // //       setState(() {
// // // // //         _errorMessage = 'Error: ${e.toString()}';
// // // // //         _isLoading = false;
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('PDF Summarizer'),
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: const EdgeInsets.all(16.0),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.stretch,
// // // // //           children: [
// // // // //             ElevatedButton(
// // // // //               onPressed: _pickPDFFile,
// // // // //               child: Text('Select PDF File'),
// // // // //             ),
// // // // //             SizedBox(height: 16),
// // // // //             if (_selectedFile != null)
// // // // //               Text(
// // // // //                 'Selected File: ${_selectedFile!.path.split('/').last}',
// // // // //                 style: TextStyle(fontSize: 16),
// // // // //               ),
// // // // //             SizedBox(height: 16),
// // // // //             ElevatedButton(
// // // // //               onPressed: _summarizePDF,
// // // // //               child: Text('Summarize PDF'),
// // // // //             ),
// // // // //             SizedBox(height: 16),
// // // // //             if (_isLoading)
// // // // //               Center(child: CircularProgressIndicator()),
// // // // //             if (_errorMessage.isNotEmpty)
// // // // //               Text(
// // // // //                 _errorMessage,
// // // // //                 style: TextStyle(color: Colors.red),
// // // // //               ),
// // // // //             SizedBox(height: 16),
// // // // //             Expanded(
// // // // //               child: SingleChildScrollView(
// // // // //                 child: Text(
// // // // //                   _summarizedText.isNotEmpty 
// // // // //                     ? 'Summary:\n$_summarizedText' 
// // // // //                     : '',
// // // // //                   style: TextStyle(fontSize: 16),
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'dart:io';
// // // // import 'package:dio/dio.dart';
// // // // import 'package:file_picker/file_picker.dart';
// // // // import 'package:flutter/material.dart';

// // // // class PdfSummarizerService {
// // // //   final Dio _dio = Dio();
  
// // // //   Future<String?> summarizePdf({
// // // //     int minLength = 100, 
// // // //     int maxLength = 300
// // // //   }) async {
// // // //     try {
// // // //       // Pick PDF file
// // // //       FilePickerResult? result = await FilePicker.platform.pickFiles(
// // // //         type: FileType.custom,
// // // //         allowedExtensions: ['pdf'],
// // // //       );

// // // //       if (result == null) {
// // // //         print('No file selected');
// // // //         return null;
// // // //       }

// // // //       // Get the file
// // // //       File file = File(result.files.single.path!);

// // // //       // Create FormData for multipart upload
// // // //       FormData formData = FormData.fromMap({
// // // //         'files': await MultipartFile.fromFile(
// // // //           file.path, 
// // // //           filename: file.path.split('/').last
// // // //         ),
// // // //         'min_length': minLength,
// // // //         'max_length': maxLength,
// // // //       });

// // // //       // Send request to summarization endpoint
// // // //       Response response = await _dio.post(
// // // //         'https://622a-2402-3a80-42a2-69e5-a0a9-be3c-873b-475d.ngrok-free.app/summarizer/summarize',
// // // //         data: formData,
// // // //         options: Options(
// // // //           contentType: 'multipart/form-data',
// // // //         ),
// // // //       );

// // // //       // Check response
// // // //       if (response.statusCode == 200) {
// // // //         return response.data['summary'];
// // // //       } else {
// // // //         print('Error: ${response.data['error']}');
// // // //         return null;
// // // //       }
// // // //     } catch (e) {
// // // //       print('Exception in PDF summarization: $e');
// // // //       return null;
// // // //     }
// // // //   }
// // // // }

// // // // // Example usage in a widget
// // // // class SummarizerScreen extends StatefulWidget {
// // // //   @override
// // // //   _SummarizerScreenState createState() => _SummarizerScreenState();
// // // // }

// // // // class _SummarizerScreenState extends State<SummarizerScreen> {
// // // //   String? _summary;
// // // //   final PdfSummarizerService _summarizerService = PdfSummarizerService();

// // // //   Future<void> _getSummary() async {
// // // //     final summary = await _summarizerService.summarizePdf(
// // // //       minLength: 50,
// // // //       maxLength: 200
// // // //     );

// // // //     setState(() {
// // // //       _summary = summary;
// // // //     });
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(title: Text('PDF Summarizer')),
// // // //       body: Center(
// // // //         child: Column(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             ElevatedButton(
// // // //               onPressed: _getSummary,
// // // //               child: Text('Select and Summarize PDF'),
// // // //             ),
// // // //             if (_summary != null) ...[
// // // //               SizedBox(height: 20),
// // // //               Padding(
// // // //                 padding: const EdgeInsets.all(16.0),
// // // //                 child: Text(
// // // //                   _summary!,
// // // //                   style: TextStyle(fontSize: 16),
// // // //                   textAlign: TextAlign.center,
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'dart:io';
// // // import 'package:dio/dio.dart';
// // // import 'package:file_picker/file_picker.dart';
// // // import 'package:flutter/material.dart';

// // // class PdfSummarizerService {
// // //   final Dio _dio = Dio();
  
// // //   // Use the ngrok URL you provided
// // //   static const String _baseUrl = 'https://622a-2402-3a80-42a2-69e5-a0a9-be3c-873b-475d.ngrok-free.app';

// // //   Future<String?> summarizePdf({
// // //     int minLength = 100, 
// // //     int maxLength = 300
// // //   }) async {
// // //     try {
// // //       // Pick PDF file
// // //       FilePickerResult? result = await FilePicker.platform.pickFiles(
// // //         type: FileType.custom,
// // //         allowedExtensions: ['pdf'],
// // //       );

// // //       if (result == null) {
// // //         print('No file selected');
// // //         return null;
// // //       }

// // //       // Get the file
// // //       File file = File(result.files.single.path!);

// // //       // Create FormData for multipart upload
// // //       FormData formData = FormData.fromMap({
// // //         'files': await MultipartFile.fromFile(
// // //           file.path, 
// // //           filename: file.path.split('/').last
// // //         ),
// // //         'min_length': minLength,
// // //         'max_length': maxLength,
// // //       });

// // //       // Print diagnostic information
// // //       print('Attempting to upload file: ${file.path}');
// // //       print('File exists: ${file.existsSync()}');
// // //       print('File size: ${file.lengthSync()} bytes');

// // //       // Send request to summarization endpoint
// // //       Response response = await _dio.post(
// // //         '$_baseUrl/summarizer/summarize',
// // //         data: formData,
// // //         options: Options(
// // //           contentType: 'multipart/form-data',
// // //           // Add these headers to help with potential CORS or ngrok issues
// // //           headers: {
// // //             'Accept': 'application/json',
// // //             'Connection': 'keep-alive',
// // //             'Accept-Encoding': 'gzip, deflate, br',
// // //           },
// // //         ),
// // //       );

// // //       // Check response
// // //       print('Response Status Code: ${response.statusCode}');
// // //       print('Response Data: ${response.data}');

// // //       if (response.statusCode == 200) {
// // //         return response.data['summary'];
// // //       } else {
// // //         print('Error: ${response.data}');
// // //         return null;
// // //       }
// // //     } on DioException catch (e) {
// // //       // More detailed error logging
// // //       print('Dio Error Type: ${e.type}');
// // //       print('Error Message: ${e.message}');
      
// // //       if (e.response != null) {
// // //         print('Error Response Status: ${e.response?.statusCode}');
// // //         print('Error Response Data: ${e.response?.data}');
// // //       }
      
// // //       return null;
// // //     } catch (e) {
// // //       print('Unexpected exception in PDF summarization: $e');
// // //       return null;
// // //     }
// // //   }
// // // }

// // // // Example usage remains the same as in previous implementation
// // // class SummarizerScreen extends StatefulWidget {
// // //   @override
// // //   _SummarizerScreenState createState() => _SummarizerScreenState();
// // // }

// // // class _SummarizerScreenState extends State<SummarizerScreen> {
// // //   String? _summary;
// // //   String? _errorMessage;
// // //   final PdfSummarizerService _summarizerService = PdfSummarizerService();

// // //   Future<void> _getSummary() async {
// // //     setState(() {
// // //       _summary = null;
// // //       _errorMessage = null;
// // //     });

// // //     final summary = await _summarizerService.summarizePdf(
// // //       minLength: 50,
// // //       maxLength: 200
// // //     );

// // //     setState(() {
// // //       _summary = summary;
// // //       _errorMessage = summary == null ? 'Failed to get summary' : null;
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text('PDF Summarizer')),
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             ElevatedButton(
// // //               onPressed: _getSummary,
// // //               child: Text('Select and Summarize PDF'),
// // //             ),
// // //             if (_errorMessage != null)
// // //               Text(
// // //                 _errorMessage!,
// // //                 style: TextStyle(color: Colors.red),
// // //               ),
// // //             if (_summary != null) ...[
// // //               SizedBox(height: 20),
// // //               Padding(
// // //                 padding: const EdgeInsets.all(16.0),
// // //                 child: Text(
// // //                   _summary!,
// // //                   style: TextStyle(fontSize: 16),
// // //                   textAlign: TextAlign.center,
// // //                 ),
// // //               ),
// // //             ],
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:io';
// // import 'package:dio/dio.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'package:flutter/material.dart';

// // class PdfSummarizerService {
// //   final Dio _dio = Dio();
  
// //   // Ngrok URL with explicit port
// //   static const String _baseUrl = 'https://622a-2402-3a80-42a2-69e5-a0a9-be3c-873b-475d.ngrok-free.app:5000';

// //   Future<String?> summarizePdf({
// //     int minLength = 100, 
// //     int maxLength = 300
// //   }) async {
// //     try {
// //       // Pick PDF file using FilePicker
// //       FilePickerResult? result = await FilePicker.platform.pickFiles(
// //         type: FileType.custom,
// //         allowedExtensions: ['pdf'],
// //       );

// //       if (result == null || result.files.single.path == null) {
// //         print('No file selected');
// //         return null;
// //       }

// //       // Get the file
// //       File file = File(result.files.single.path!);

// //       // Verify file exists and is readable
// //       if (!file.existsSync()) {
// //         print('File does not exist');
// //         return null;
// //       }

// //       // Create FormData for multipart upload
// //       FormData formData = FormData.fromMap({
// //         'files': await MultipartFile.fromFile(
// //           file.path, 
// //           filename: file.path.split('/').last
// //         ),
// //         'min_length': minLength,
// //         'max_length': maxLength,
// //       });

// //       // Detailed logging
// //       print('Uploading file: ${file.path}');
// //       print('File size: ${file.lengthSync()} bytes');

// //       // Send request to summarization endpoint
// //       Response response = await _dio.post(
// //         '$_baseUrl/summarizer/summarize',
// //         data: formData,
// //         options: Options(
// //           contentType: 'multipart/form-data',
// //           headers: {
// //             'Accept': 'application/json',
// //             'Connection': 'keep-alive',
// //           },
// //         ),
// //       );

// //       // Log response details
// //       print('Response Status Code: ${response.statusCode}');
// //       print('Response Data: ${response.data}');

// //       // Check and return summary
// //       if (response.statusCode == 200 && response.data['summary'] != null) {
// //         return response.data['summary'];
// //       } else {
// //         print('Error in response: ${response.data}');
// //         return null;
// //       }
// //     } on DioException catch (e) {
// //       // Comprehensive error logging for Dio exceptions
// //       print('Dio Error Details:');
// //       print('Error Type: ${e.type}');
// //       print('Error Message: ${e.message}');
      
// //       if (e.response != null) {
// //         print('Error Response Status: ${e.response?.statusCode}');
// //         print('Error Response Data: ${e.response?.data}');
// //       }
      
// //       return null;
// //     } catch (e) {
// //       print('Unexpected error in PDF summarization: $e');
// //       return null;
// //     }
// //   }
// // }

// // class SummarizerScreen extends StatefulWidget {
// //   @override
// //   _SummarizerScreenState createState() => _SummarizerScreenState();
// // }

// // class _SummarizerScreenState extends State<SummarizerScreen> {
// //   String? _summary;
// //   String? _errorMessage;
// //   final PdfSummarizerService _summarizerService = PdfSummarizerService();

// //   Future<void> _getSummary() async {
// //     setState(() {
// //       _summary = null;
// //       _errorMessage = null;
// //     });

// //     try {
// //       final summary = await _summarizerService.summarizePdf(
// //         minLength: 50,
// //         maxLength: 200
// //       );

// //       setState(() {
// //         if (summary != null) {
// //           _summary = summary;
// //         } else {
// //           _errorMessage = 'Failed to generate summary. Check logs for details.';
// //         }
// //       });
// //     } catch (e) {
// //       setState(() {
// //         _errorMessage = 'An unexpected error occurred: $e';
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('PDF Summarizer')),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             ElevatedButton(
// //               onPressed: _getSummary,
// //               child: Text('Select and Summarize PDF'),
// //             ),
// //             if (_errorMessage != null)
// //               Padding(
// //                 padding: const EdgeInsets.all(16.0),
// //                 child: Text(
// //                   _errorMessage!,
// //                   style: TextStyle(color: Colors.red),
// //                   textAlign: TextAlign.center,
// //                 ),
// //               ),
// //             if (_summary != null)
// //               Expanded(
// //                 child: SingleChildScrollView(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Text(
// //                     _summary!,
// //                     style: TextStyle(fontSize: 16),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:http/http.dart' as http;
// import 'dart:io';
// import 'dart:convert';
// import 'package:path/path.dart' as path;

// class PdfSummarizer {
//   Future<String> summarizePdf({
//     required File file, 
//     int minLength = 100, 
//     int maxLength = 300
//   }) async {
//     try {
//       final url = Uri.parse('https://622a-2402-3a80-42a2-69e5-a0a9-be3c-873b-475d.ngrok-free.app/summarizer/summarize');

//       var request = http.MultipartRequest('POST', url);
//       request.files.add(await http.MultipartFile.fromPath(
//         'files',
//         file.path,
//         filename: path.basename(file.path),
//       ));

//       request.fields['min_length'] = minLength.toString();
//       request.fields['max_length'] = maxLength.toString();

//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         return jsonResponse['summary'] ?? 'No summary available';
//       } else {
//         var errorResponse = json.decode(response.body);
//         throw Exception(errorResponse['error'] ?? 'Failed to summarize PDF');
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<File?> pickPdfFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
      
//       return File(result.files.single.path!);
//     }
//     return null;
//   }
// }

// class SummarizerScreen extends StatefulWidget{
//     const SummarizerScreen({super.key});

//   @override
//   State<SummarizerScreen> createState() => _SummarizerScreenState();
// }

// class _SummarizerScreenState extends State<SummarizerScreen> {
//   final PdfSummarizer _summarizer = PdfSummarizer();
//   File? _file;
//   String _summary = '';
//   bool _isLoading = false;

//   Future<void> _pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf'],
//     );

//     if (result != null) {
//       setState(() {
//         _file = File(result.files.single.path!);
//       });
//     }
//   }

//   Future<void> _pickAndAnalyzePdf() async {
//     setState(() {
//       _isLoading = true;
//       _summary = '';
//     });

//     try {
//       // Pick the file
//        await _pickFile();
      
//       if (_file != null) {
//         // Analyze the picked file
//         _summary = await _summarizer.summarizePdf(file: _file!);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${e.toString()}')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Summarizer'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : (_summary.isEmpty 
//               ? _buildUploadScreen() 
//               : _buildSummaryScreen()),
//     );
//   }

//   Widget _buildUploadScreen() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: _pickAndAnalyzePdf,
//         child: Text('Pick PDF to Summarize'),
//       ),
//     );
//   }

//   Widget _buildSummaryScreen() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Summary', 
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//           SizedBox(height: 20),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Text(_summary),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: _pickAndAnalyzePdf,
//             child: Text('Summarize Another PDF'),
//           )
//         ],
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class SummarizerScreen extends StatefulWidget {
  @override
  _SummarizerScreenState createState() => _SummarizerScreenState();
}

class _SummarizerScreenState extends State<SummarizerScreen> {
  int _selectedIndex = 2; // Set to 2 for the home icon
  File? _file;
  String _summary = '';
  bool _isLoading = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  Future<void> _analyzePdf() async {
    if (_file == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final String ngrokKey = 'https://7196-2402-3a80-42ba-8f9e-2468-ba73-437b-f5f.ngrok-free.app';
      final url = Uri.parse(ngrokKey+'/summarize');

      var request = http.MultipartRequest('POST', url);
      // Add the file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'files',
      _file!.path,
      filename: path.basename(_file!.path),
    ));

    // Add headers
    var headers = {
      "Content-Type": "multipart/form-data",
      // Add other headers if necessary
    };
    request.headers.addAll(headers);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Parse the JSON response and extract the "analysis" field
        var jsonResponse = json.decode(response.body);
        setState(() {
          _summary = jsonResponse['summary'] ?? 'No summary available';
        });
      } else {
        throw Exception('Failed to analyze PDF');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Reports',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        actions: [
          
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : (_summary.isEmpty ? _buildUploadScreen() : _buildSummaryScreen()),
    );
  }

  Widget _buildUploadScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: _file == null
                ? IconButton(
                    icon: Icon(Icons.upload_file, size: 50),
                    onPressed: _pickFile,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.file_present, size: 50, color: Colors.green),
                      SizedBox(height: 10),
                      Text(
                        'File Uploaded',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        path.basename(_file!.path),
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
          ),
          SizedBox(height: 20),
          Text(
            _file == null ? 'Upload File Here' : 'File Ready for Analysis',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 1, 42, 3),
                  Colors.green
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: _file != null ? _analyzePdf : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Text(_file != null ? 'Analyze PDF' : 'Proceed'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,)),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Text(_summary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



