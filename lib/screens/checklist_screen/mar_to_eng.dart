// import 'package:google_mlkit_translation/google_mlkit_translation.dart';
// import 'package:flutter/material.dart';

// class Translator {
//   // late final OnDeviceTranslator translator;

//   // OnDeviceTranslator() {
//   //   translator = onDeviceTranslator(
//   //     sourceLanguage: TranslateLanguage.marathi,
//   //     targetLanguage: TranslateLanguage.english,
//   //   );
//   // }

// final TranslateLanguage sourceLanguage = TranslateLanguage.marathi;
// final TranslateLanguage targetLanguage = TranslateLanguage.english;

// final onDeviceTranslator = OnDeviceTranslator(sourceLanguage: TranslateLanguage.marathi, targetLanguage: TranslateLanguage.english);

//   Future<String> translateText(String marathiText) async {
//     try {
//       final String response = await onDeviceTranslator.translateText(marathiText);
//       return response;
//     } catch (e) {
//       return "Error: $e";
//     }
//   }

  

//   Future<void> closeTranslator() async {
//     await onDeviceTranslator.close();
//   }
// }

// class TranslationPage extends StatefulWidget {
//   @override
//   _TranslationPageState createState() => _TranslationPageState();
// }

// class _TranslationPageState extends State<TranslationPage> {
//   final Translator translator = Translator();
//   final TextEditingController _textController = TextEditingController();
//   String _translatedText = "";

//   void translate() async {
//     if (_textController.text.isNotEmpty) {
//       final result = await translator.translateText(_textController.text);
//       setState(() {
//         _translatedText = result;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _textController.dispose();
//     translator.closeTranslator();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ML Kit Translation"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _textController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: "Enter Marathi Text",
//               ),
//               maxLines: null,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: translate,
//               child: Text("Translate to English"),
//             ),
//             SizedBox(height: 20),
//             const Text(
//               "Translated Text:",
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(_translatedText),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class Translator {
  late OnDeviceTranslator _onDeviceTranslator;

  Translator() {
    _onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: TranslateLanguage.marathi,
      targetLanguage: TranslateLanguage.english,
    );
  }

  Future<String> translateText(String marathiText) async {
    try {
      final String response = await _onDeviceTranslator.translateText(marathiText);
      return response;
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<void> closeTranslator() async {
    await _onDeviceTranslator.close();
  }
}

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final Translator translator = Translator();
  final TextEditingController _textController = TextEditingController();
  String _translatedText = "";

  void translate() async {
    if (_textController.text.isNotEmpty) {
      final result = await translator.translateText(_textController.text);
      setState(() {
        _translatedText = result;
      });
    }
  }


  @override
  void dispose() {
    _textController.dispose();
    translator.closeTranslator();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ML Kit Translation"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter Marathi Text",
              ),
              maxLines: null,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: translate,
              child: Text("Translate to English"),
            ),
            SizedBox(height: 20),
            Text(
              "Translated Text:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(_translatedText),
          ],
        ),
      ),
    );
  }
}


void downloadTranslationModel() async {
  final modelManager = OnDeviceTranslatorModelManager();
  await modelManager.downloadModel('marathi');
  await modelManager.downloadModel('english');
}