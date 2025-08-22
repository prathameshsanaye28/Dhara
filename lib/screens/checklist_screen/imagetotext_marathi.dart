// import 'dart:io';
// import 'package:dhara_sih/models/shiftIncharge.dart';
// import 'package:dhara_sih/resources/user_provider.dart';
// import 'package:dhara_sih/screens/checklist_screen/create_checklist.dart';
// import 'package:dhara_sih/widgets/custom_green_button.dart';
// import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import 'package:rive/rive.dart' as rive;

// class ImageToTextMarathiScreen extends StatefulWidget {
//   const ImageToTextMarathiScreen({Key? key}) : super(key: key);

//   @override
//   State<ImageToTextMarathiScreen> createState() => _ImageToTextMarathiScreenState();
// }

// class _ImageToTextMarathiScreenState extends State<ImageToTextMarathiScreen> {
//   File? selectedMedia;
//   final ImagePicker _imagePicker = ImagePicker();
//   String extractedText = ""; // Store the extracted text

//   @override
//   Widget build(BuildContext context) {
//     final ShiftIncharge? user = Provider.of<UserProvider>(context).getUser;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: const Text(
//           "Image to Text",
//           style: TextStyle(color: Colors.white),
//         ),
//         elevation: 0,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final XFile? image =
//               await _imagePicker.pickImage(source: ImageSource.gallery);
//           if (image != null) {
//             setState(() {
//               selectedMedia = File(image.path);
//             });

//             // Extract text when a new image is picked
//             String? text = await _extractText(File(image.path));
//             setState(() {
//               extractedText = text ?? "No text found";
//             });
//           }
//         },
//         child: const Icon(Icons.add),
//       ),
//       body: Stack(
//         children: [
//           const rive.RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   GlassEffectContainer(
//                     width: double.infinity,
//                     height: 900,
//                     borderRadius: 25,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           _imageView(),
//                           const SizedBox(height: 20),
//                           // Optional: Show extracted text
//                           Text(
//                             extractedText,
//                             style: const TextStyle(color: Colors.white),
//                             maxLines: 10,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   // Only show button if text is extracted
//                   // if (extractedText.isNotEmpty)
//                   //   GestureDetector(
//                   //     onTap: () {
//                   //       // Navigate to CreateChecklistScreen with extracted text
//                   //       Navigator.push(
//                   //         context,
//                   //         MaterialPageRoute(
//                   //           builder: (context) => CreateChecklistScreen(
//                   //             extractedText: extractedText,
//                   //             shiftInchargeId: user?.id??'', // Replace with actual user ID
//                   //           ),
//                   //         ),
//                   //       );
//                   //     },
//                   //     child: const CustomGreenButton(label: 'Create Checklist'),
//                   //   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _imageView() {
//     if (selectedMedia == null) {
//       return const Center(
//         child: Text(
//           "Pick image",
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     }
//     return Center(
//       child: Image.file(
//         selectedMedia!,
//         width: 200,
//         height: 400,
//         fit: BoxFit.contain,
//       ),
//     );
//   }

//   Future<String?> _extractText(File file) async {
//     var textRecognizer = TextRecognizer(script: TextRecognitionScript.devanagiri);
//     final InputImage inputImage = InputImage.fromFile(file);
//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(inputImage);
//     textRecognizer.close();
//     return recognizedText.text;
//   }
// }





import 'dart:io';
import 'package:dhara_sih/models/shiftIncharge.dart';
import 'package:dhara_sih/resources/user_provider.dart';
import 'package:dhara_sih/screens/checklist_screen/create_checklist.dart';
import 'package:dhara_sih/widgets/custom_green_button.dart';
import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageToTextMarathiScreen extends StatefulWidget {
  const ImageToTextMarathiScreen({Key? key}) : super(key: key);

  @override
  State<ImageToTextMarathiScreen> createState() => _ImageToTextMarathiScreenState();
}

class _ImageToTextMarathiScreenState extends State<ImageToTextMarathiScreen> {
  File? selectedMedia;
  final ImagePicker _imagePicker = ImagePicker();
  String extractedText = ""; // Store the extracted Marathi text
  String translatedText = ""; // Store the translated English text
  bool _isLoading = false;

  // Replace with your actual Gemini API key
  static const String _geminiApiKey = 'AIzaSyA14uRfjU32vsi4JdB8YDXIMv5QODZE1ao';

  @override
  Widget build(BuildContext context) {
    final ShiftIncharge? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Image to Text Translation",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final XFile? image =
              await _imagePicker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            setState(() {
              selectedMedia = File(image.path);
              extractedText = ""; // Reset extracted text
              translatedText = ""; // Reset translated text
            });

            // Extract text when a new image is picked
            String? text = await _extractText(File(image.path));
            setState(() {
              extractedText = text ?? "No text found";
            });

            // Automatically translate if text is extracted
            if (extractedText.isNotEmpty && extractedText != "No text found") {
              await _translateText();
            }
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          const rive.RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  GlassEffectContainer(
                    width: double.infinity,
                    height: 1200,
                    borderRadius: 25,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _imageView(),
                          const SizedBox(height: 20),
                          // Extracted Marathi Text
                          Text(
                            "Extracted Marathi Text:",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            extractedText,
                            style: const TextStyle(color: Colors.white),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 20),
                          // Translated English Text
                          Text(
                            "Translated English Text:",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          _isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  translatedText,
                                  style: const TextStyle(color: Colors.white),
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Commented out for now - you can uncomment and modify as needed
                  // if (translatedText.isNotEmpty)
                  //   GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => CreateChecklistScreen(
                  //             extractedText: translatedText,
                  //             shiftInchargeId: user?.id??'',
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //     child: const CustomGreenButton(label: 'Create Checklist'),
                  //   )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageView() {
    if (selectedMedia == null) {
      return const Center(
        child: Text(
          "Pick image",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return Center(
      child: Image.file(
        selectedMedia!,
        width: 200,
        height: 400,
        fit: BoxFit.contain,
      ),
    );
  }

  Future<String?> _extractText(File file) async {
    var textRecognizer = TextRecognizer(script: TextRecognitionScript.devanagiri);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    textRecognizer.close();
    return recognizedText.text;
  }

  Future<void> _translateText() async {
    if (extractedText.isEmpty) return;

    setState(() {
      _isLoading = true;
      translatedText = "";
    });

    try {
      final response = await http.post(
        Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$_geminiApiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {
                  'text': 'Translate the following text to English: "$extractedText"'
                }
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.4,
            'maxOutputTokens': 800,
          }
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final String? translatedContent = responseBody['candidates']?[0]['content']['parts']?[0]['text'];
        
        setState(() {
          translatedText = translatedContent ?? "Translation failed";
          _isLoading = false;
        });
      } else {
        setState(() {
          translatedText = "Error: ${response.statusCode}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        translatedText = "Translation error: $e";
        _isLoading = false;
      });
    }
  }
}