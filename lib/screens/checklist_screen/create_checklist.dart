import 'package:dhara_sih/resources/checklist_services.dart';
import 'package:flutter/material.dart';
import 'package:dhara_sih/models/checklist.dart';

class CreateChecklistScreen extends StatefulWidget {
  final String extractedText;
  final String shiftInchargeId;

  const CreateChecklistScreen({
    Key? key, 
    required this.extractedText, 
    required this.shiftInchargeId
  }) : super(key: key);

  @override
  _CreateChecklistScreenState createState() => _CreateChecklistScreenState();
}

class _CreateChecklistScreenState extends State<CreateChecklistScreen> {
  late List<TextEditingController> _controllers;
  late List<String> _items;
  final TextEditingController _titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Split extracted text into lines
    _items = widget.extractedText.split('\n')
        .where((item) => item.trim().isNotEmpty)
        .toList();
    
    // Create controllers for each item
    _controllers = _items.map((item) => TextEditingController(text: item)).toList();
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _controllers.forEach((controller) => controller.dispose());
    _titleController.dispose();
    super.dispose();
  }

  void _saveChecklist() async {
    // Validate title
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a checklist title')),
      );
      return;
    }

    // Prepare checklist items
    List<Map<String, dynamic>> items = _controllers.map((controller) {
      return {
        'description': controller.text,
        'status': null, // Initially no status
      };
    }).toList();

    // Create Checklist object
    Checklist newChecklist = Checklist(
      title: _titleController.text,
      shiftInchargeUid: widget.shiftInchargeId,
      timestamp: DateTime.now(),
      items: items,
    );

    // Save checklist
    try {
      await ChecklistServices().createChecklist(newChecklist, widget.shiftInchargeId);
      
      // Show success and pop back to previous screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checklist Created Successfully')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error creating checklist: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Create Checklist',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveChecklist,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Checklist Title Input
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Checklist Title',
                  labelStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[900],
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20),

              // Checklist Items
              const Text(
                'Checklist Items',
                style: TextStyle(
                  color: Colors.white, 
                  fontSize: 18, 
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 10),
              //   const Text(
              //   widget.shiftInchargeId,
              //   style: TextStyle(
              //     color: Colors.white, 
              //     fontSize: 18, 
              //     fontWeight: FontWeight.bold
              //   ),
              // ),
              
              // Dynamic list of editable checklist items
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: _controllers[index],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[900],
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}