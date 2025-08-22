// // // import 'dart:io';

// // // import 'package:dhara_sih/widgets/custom_green_button.dart';
// // // import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:gallery_picker/gallery_picker.dart';
// // // import 'package:gallery_picker/models/media_file.dart';
// // // import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// // // import 'package:rive/rive.dart' as rive;

// // // class ImageToTextScreen extends StatefulWidget {
// // //   const ImageToTextScreen({super.key});

// // //   @override
// // //   State<ImageToTextScreen> createState() => _ImageToTextScreenState();
// // // }

// // // class _ImageToTextScreenState extends State<ImageToTextScreen> {
// // //   File? selectedMedia;
  
  
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //         backgroundColor: Colors.black,
// // //         appBar: AppBar(
// // //           backgroundColor: Colors.transparent,
// // //           title: Text(
// // //             "",
// // //             style: TextStyle(
// // //                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
// // //           ),
// // //           elevation: 0,
// // //           actions: [
// // //             Icon(
// // //               Icons.warning,
// // //               color: Colors.red,
// // //             ),
// // //             SizedBox(
// // //               width: 20,
// // //             ),
// // //             CircleAvatar(
// // //               backgroundImage: NetworkImage(
// // //                   "https://plus.unsplash.com/premium_photo-1674489157120-9c386f7173d9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
// // //             ),
// // //             SizedBox(
// // //               width: 20,
// // //             ),
// // //           ],
// // //         ),
// // //         floatingActionButton: FloatingActionButton(onPressed: ()async{
// // //           List<MediaFile>? media = await GalleryPicker.pickMedia(context: context, singleMedia: true);
// // //           if(media != null && media.isNotEmpty){
// // //             var data = await media.first.getFile();
// // //             setState(() {
// // //               selectedMedia = data;
// // //             });
// // //           }

// // //         },
// // //         child: Icon(Icons.add),
// // //         ),
// // //         body: Stack(
// // //           children: [
// // //             const rive.RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
// // //             SingleChildScrollView(
// // //               child: Padding(
// // //                 padding: const EdgeInsets.all(10.0),
// // //                 child: Column(
// // //                   children: [
// // //                     Text(
// // //                       "Image to text",
// // //                       style: TextStyle(
// // //                           fontSize: 20,
// // //                           fontWeight: FontWeight.bold,
// // //                           color: Colors.white),
// // //                     ),
// // //                     SizedBox(
// // //                       height: 10,
// // //                     ),
// // //                     GlassEffectContainer(
// // //                         width: double.infinity,
// // //                         height: 800,
// // //                         borderRadius: 25,
// // //                         child: Padding(
// // //                           padding: const EdgeInsets.all(8.0),
// // //                           child: Column(
// // //                             children: [

// // //                             ],
// // //                           ),
// // //                         )),
// // //                     SizedBox(
// // //                       height: 30,
// // //                     ),
// // //                     // GestureDetector(
// // //                     //     onTap: () {
// // //                     //       Navigator.push(
// // //                     //           context,
// // //                     //           MaterialPageRoute(
// // //                     //               builder: (context) => RiskIndexScreen()));
// // //                     //     },
// // //                     //     child: CustomGreenButton(label: 'Analyze Risk'))
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ));
// // //   }



// // //   Widget buildUI(){
// // //   return Column(
// // //     mainAxisSize: MainAxisSize.max,
// // //     mainAxisAlignment: MainAxisAlignment.center,
// // //     crossAxisAlignment: CrossAxisAlignment.center,
// // //     children: [
// // //       _imageView(),
// // //       _extractTextView(),
// // //     ],
// // //   );
// // // }

// // // Widget _imageView(){
// // //   if(selectedMedia == null){
// // //     return const Center(
// // //       child: Text("Pick image"),
// // //     );
// // //   }
// // //   return Center(
// // //     child: Image.file(selectedMedia!, width: 200,),
// // //   );
// // // }

// // // Widget _extractTextView(){
// // //   if(selectedMedia == null){
// // //     return const Center(
// // //       child: Text("No result"),
// // //     );
// // //   }
// // //   return FutureBuilder(future: _extractText(selectedMedia!), builder: (context, snapshot){
// // //     return Text(snapshot.data??"");
// // //   });
// // // }

// // // Future<String?> _extractText(File file)async{
// // //   var textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
// // //   final InputImage inputImage = InputImage.fromFile(file);
// // //   final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
// // //   String text = recognizedText.text;
// // //   textRecognizer.close();
// // //   return text;
// // // }

// // // }


// // import 'dart:io';
// // import 'package:dhara_sih/screens/checklist_screen/checklist_screen.dart';
// // import 'package:dhara_sih/widgets/custom_green_button.dart';
// // import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:rive/rive.dart' as rive;

// // class ImageToTextScreen extends StatefulWidget {
// //   const ImageToTextScreen({super.key});

// //   @override
// //   State<ImageToTextScreen> createState() => _ImageToTextScreenState();
// // }

// // class _ImageToTextScreenState extends State<ImageToTextScreen> {
// //   File? selectedMedia;
// //   final ImagePicker _imagePicker = ImagePicker();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         backgroundColor: Colors.black,
// //         appBar: AppBar(
// //           backgroundColor: Colors.transparent,
// //           title: Text(
// //             "",
// //             style: TextStyle(
// //                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
// //           ),
// //           elevation: 0,
// //           actions: [
// //             Icon(
// //               Icons.warning,
// //               color: Colors.red,
// //             ),
// //             SizedBox(
// //               width: 20,
// //             ),
// //             CircleAvatar(
// //               backgroundImage: NetworkImage(
// //                   "https://plus.unsplash.com/premium_photo-1674489157120-9c386f7173d9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
// //             ),
// //             SizedBox(
// //               width: 20,
// //             ),
// //           ],
// //         ),
// //         floatingActionButton: FloatingActionButton(
// //           onPressed: () async {
// //             final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
// //             if (image != null) {
// //               setState(() {
// //                 selectedMedia = File(image.path);
// //               });
// //             }
// //           },
// //           child: Icon(Icons.add),
// //         ),
// //         body: Stack(
// //           children: [
// //             const rive.RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
// //             SingleChildScrollView(
// //               child: Padding(
// //                 padding: const EdgeInsets.all(10.0),
// //                 child: Column(
// //                   children: [
// //                     Text(
// //                       "Image to text",
// //                       style: TextStyle(
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.white),
// //                     ),
// //                     SizedBox(
// //                       height: 10,
// //                     ),
// //                     GlassEffectContainer(
// //                         width: double.infinity,
// //                         height: 800,
// //                         borderRadius: 25,
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(8.0),
// //                           child: Column(
// //                             children: [
// //                               buildUI(),
// //                             ],
// //                           ),
// //                         )),
// //                     SizedBox(
// //                       height: 30,
// //                     ),
// //                     GestureDetector(
// //                         onTap: () {
// //                           Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                   builder: (context) => ChecklistPage(checklist:_extractTextView().toString())));
// //                         },
// //                         child: CustomGreenButton(label: 'Analyze Risk'))
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ));
// //   }

// //   Widget buildUI() {
// //     return Column(
// //       mainAxisSize: MainAxisSize.max,
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         _imageView(),
// //         _extractTextView(),
// //       ],
// //     );
// //   }

// //   Widget _imageView() {
// //     if (selectedMedia == null) {
// //       return const Center(
// //         child: Text("Pick image", style: TextStyle(color: Colors.white),),
// //       );
// //     }
// //     return Center(
// //       child: Image.file(
// //         selectedMedia!,
// //         width: 200,
// //       ),
// //     );
// //   }

// //   Widget _extractTextView() {
// //     if (selectedMedia == null) {
// //       return const Center(
// //         child: Text("No result"),
// //       );
// //     }
// //     return FutureBuilder(
// //         future: _extractText(selectedMedia!),
// //         builder: (context, snapshot) {
// //           return Text(snapshot.data ?? "",style: TextStyle(color: Colors.white),);
// //         });
// //   }

// //   Future<String?> _extractText(File file) async {
// //     var textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
// //     final InputImage inputImage = InputImage.fromFile(file);
// //     final RecognizedText recognizedText =
// //         await textRecognizer.processImage(inputImage);
// //     String text = recognizedText.text;
// //     textRecognizer.close();
// //     return text;
// //   }
// // }






// import 'dart:io';
// import 'package:dhara_sih/screens/checklist_screen/checklist_screen.dart';
// import 'package:dhara_sih/widgets/custom_green_button.dart';
// import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:rive/rive.dart' as rive;

// class ImageToTextScreen extends StatefulWidget {
//   const ImageToTextScreen({super.key});

//   @override
//   State<ImageToTextScreen> createState() => _ImageToTextScreenState();
// }

// class _ImageToTextScreenState extends State<ImageToTextScreen> {
//   File? selectedMedia;
//   final ImagePicker _imagePicker = ImagePicker();
//   String extractedText = ""; // Store the extracted text

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           title: const Text(
//             "",
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           elevation: 0,
//           actions: [
//             const Icon(
//               Icons.warning,
//               color: Colors.red,
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             const CircleAvatar(
//               backgroundImage: NetworkImage(
//                   "https://plus.unsplash.com/premium_photo-1674489157120-9c386f7173d9?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async {
//             final XFile? image =
//                 await _imagePicker.pickImage(source: ImageSource.gallery);
//             if (image != null) {
//               setState(() {
//                 selectedMedia = File(image.path);
//               });

//               // Extract text when a new image is picked
//               String? text = await _extractText(File(image.path));
//               setState(() {
//                 extractedText = text ?? "No text found";
//               });
//             }
//           },
//           child: const Icon(Icons.add),
//         ),
//         body: Stack(
//           children: [
//             const rive.RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
//             SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   children: [
//                     const Text(
//                       "Image to text",
//                       style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     GlassEffectContainer(
//                         width: double.infinity,
//                         height: 500,
//                         borderRadius: 25,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             children: [
//                               _imageView(),
//                               const SizedBox(height: 20),
//                               // Text(
//                               //   extractedText,
//                               //   style: const TextStyle(color: Colors.white),
//                               // ),
//                             ],
//                           ),
//                         )),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     GestureDetector(
//                         onTap: () {
//                           // Pass the extracted text to ChecklistPage
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => ChecklistPage(
//                                       checklist: extractedText)));
//                         },
//                         child: const CustomGreenButton(label: 'Analyze Risk'))
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
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
//       ),
//     );
//   }

//   Future<String?> _extractText(File file) async {
//     var textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
//     final InputImage inputImage = InputImage.fromFile(file);
//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(inputImage);
//     textRecognizer.close();
//     return recognizedText.text; // Return the extracted text
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

class ImageToTextScreen extends StatefulWidget {
  const ImageToTextScreen({Key? key}) : super(key: key);

  @override
  State<ImageToTextScreen> createState() => _ImageToTextScreenState();
}

class _ImageToTextScreenState extends State<ImageToTextScreen> {
  File? selectedMedia;
  final ImagePicker _imagePicker = ImagePicker();
  String extractedText = ""; // Store the extracted text

  @override
  Widget build(BuildContext context) {
    final ShiftIncharge? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Image to Text",
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
            });

            // Extract text when a new image is picked
            String? text = await _extractText(File(image.path));
            setState(() {
              extractedText = text ?? "No text found";
            });
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
                    height: 500,
                    borderRadius: 25,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _imageView(),
                          const SizedBox(height: 20),
                          // Optional: Show extracted text
                          // Text(
                          //   extractedText,
                          //   style: const TextStyle(color: Colors.white),
                          //   maxLines: 10,
                          //   overflow: TextOverflow.ellipsis,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Only show button if text is extracted
                  if (extractedText.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        // Navigate to CreateChecklistScreen with extracted text
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateChecklistScreen(
                              extractedText: extractedText,
                              shiftInchargeId: user?.id??'', // Replace with actual user ID
                            ),
                          ),
                        );
                      },
                      child: const CustomGreenButton(label: 'Create Checklist'),
                    )
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
    var textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    textRecognizer.close();
    return recognizedText.text;
  }
}