import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

class GeminiUploadScreen extends StatefulWidget {
  const GeminiUploadScreen({Key? key}) : super(key: key);

  @override
  _GeminiUploadScreenState createState() => _GeminiUploadScreenState();
}

class _GeminiUploadScreenState extends State<GeminiUploadScreen> {
  XFile? _pickedFile;
  String _responseText = '';
  bool _isLoading = false;
  final String _apiKey = 'AIzaSyC3pgYPS5kOf0NQgDjQvL6tEPi4wmB1eFE';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedFile = pickedFile;
    });
  }

  Future<void> _processImage() async {
    if (_pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _responseText = '';
    });

    try {
      final model = GenerativeModel(
        model: 'gemini-2.0-flash-exp',
        apiKey: _apiKey,
        generationConfig: GenerationConfig(
          temperature: 1,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 8192,
          responseMimeType: 'text/plain',
        ),
      );

      final chat = model.startChat(history: [
        Content.multi([
          FilePart(Uri.file(_pickedFile!.path)),
          TextPart(
              'see this is one shift log for a particular mine, extract its data in English and give me all the fields of this exactly in a DB-like format properly. Only give me the fields, data type, and description table. Nothing else. Only give the CSV, no other paragraph text. Just CSV, only the table directly.'),
        ]),
        Content.model([
          TextPart(
              '```csv\nField,Data Type,Description\n"Mine Name",TEXT,"Name of the mine"\n"Owner Name",TEXT,"Name of the mine owner"\n"District Name",TEXT,"Name of the district"\n"Seam Name",TEXT,"Name of the seam"\n"Date",DATE,"Date of the shift"\n"Shift Hours",TEXT,"Start and end time of the shift"\n"Person in Charge Name",TEXT,"Name of the person who took charge of the shift"\n"Time of Charge",TIME,"Time of taking the charge"\n"Location",TEXT,"Location of the mine"\n"Break Interval",TEXT,"Duration of the break"\n"Inspection Period From",DATETIME,"Start time of the inspection period"\n"Inspection Period To",DATETIME,"End time of the inspection period"\n"First Inspection",TEXT,"Details or time of first inspection"\n"Second Inspection",TEXT,"Details or time of second inspection"\n"Third Inspection",TEXT,"Details or time of third inspection"\n"Number of Persons Working",INTEGER,"Number of persons working under the inspector"\n"Defect - Ventilation",TEXT,"Defects found in Ventilation"\n"Defect - Roof and Side Support",TEXT,"Defects found in Roof and Side Support"\n"Defect - Goaf Edge",TEXT,"Defects found at Goaf Edge"\n"Defect - Fencing",TEXT,"Defects found in Fencing"\n"Defect - Cleanliness",TEXT,"Defects found in Cleanliness"\n"Action Taken - Ventilation",TEXT,"Action taken for Ventilation defects"\n"Action Taken - Roof and Side Support",TEXT,"Action taken for Roof and Side Support defects"\n"Action Taken - Goaf Edge",TEXT,"Action taken for Goaf Edge defects"\n"Action Taken - Fencing",TEXT,"Action taken for Fencing defects"\n"Action Taken - Cleanliness",TEXT,"Action taken for Cleanliness defects"\n"Safety Instructions Given to People",TEXT,"Safety instructions given to the workers"\n"Details of Person Moved",TEXT,"Details of people moved from their designated place of work"\n"Details of Inexperienced Person",TEXT,"Details of inexperienced people and person who has supervised them"\n"Safety Material - Timber",TEXT,"Details of timber used"\n"Safety Material - Support (if more than 3 meters)",TEXT,"Details of support used"\n"Safety Material - Ladder",TEXT,"Details of ladder used"\n"Safety Material - Cage or Carbon Monoxide Detection",TEXT,"Details of cage used and Carbon Monoxide Detection devices"\n"Safety Material - Other",TEXT,"Details of other safety materials used"\n"Details of Safety Material If any is missing",TEXT,"Action taken if any material missing"\n"Inspection of Secondary Exit Route",TEXT,"Inspection of secondary exit route"\n"Location1",TEXT,"Location 1 where support is removed"\n"Number of Cogging, Sleeper Removed1",INTEGER,"Number of Cogging and Sleeper Removed from Location 1"\n"Number of Props Removed1",INTEGER,"Number of Props Removed from Location 1"\n"Other Support Removed1",TEXT,"Other types of support removed from Location 1"\n"Location2",TEXT,"Location 2 where support is removed"\n"Number of Cogging, Sleeper Removed2",INTEGER,"Number of Cogging and Sleeper Removed from Location 2"\n"Number of Props Removed2",INTEGER,"Number of Props Removed from Location 2"\n"Other Support Removed2",TEXT,"Other types of support removed from Location 2"\n"Location3",TEXT,"Location 3 where support is removed"\n"Number of Cogging, Sleeper Removed3",INTEGER,"Number of Cogging and Sleeper Removed from Location 3"\n"Number of Props Removed3",INTEGER,"Number of Props Removed from Location 3"\n"Other Support Removed3",TEXT,"Other types of support removed from Location 3"\n"Method/Equipment for Support Removal",TEXT,"Method and equipment used for support removal"\n```\n'),
        ]),
      ]);

      final response =
          await chat.sendMessage(Content.text('Process the image'));

      setState(() {
        _responseText = response.text ?? 'No response received';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _responseText = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Image Processor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 16),
            if (_pickedFile != null)
              Image.file(
                File(_pickedFile!.path),
                height: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _processImage,
              child: const Text('Process Image with Gemini'),
            ),
            const SizedBox(height: 16),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            if (_responseText.isNotEmpty && !_isLoading)
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _responseText,
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
