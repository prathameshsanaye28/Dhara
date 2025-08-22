import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EquipmentAssessmentModel {
  final String equipmentName;
  final String equipmentType;
  final int equipmentAge;
  final String lastMaintenanceDate;
  final String currentCondition;
  final String usageFrequency;

  EquipmentAssessmentModel({
    required this.equipmentName,
    required this.equipmentType,
    required this.equipmentAge,
    required this.lastMaintenanceDate,
    required this.currentCondition,
    required this.usageFrequency,
  });

  Map<String, dynamic> toJson() {
    return {
      'equipment_name': equipmentName,
      'equipment_type': equipmentType,
      'equipment_age': equipmentAge,
      'last_maintenance_date': lastMaintenanceDate,
      'current_condition': currentCondition,
      'usage_frequency': usageFrequency,
    };
  }
}

class EquipmentAssessmentResponse {
  final String status;
  final String timestamp;
  final Map<String, dynamic> equipmentDetails;
  final String safetyAssessment;

  EquipmentAssessmentResponse({
    required this.status,
    required this.timestamp,
    required this.equipmentDetails,
    required this.safetyAssessment,
  });

  factory EquipmentAssessmentResponse.fromJson(Map<String, dynamic> json) {
    return EquipmentAssessmentResponse(
      status: json['status'],
      timestamp: json['timestamp'],
      equipmentDetails: json['equipment_details'],
      safetyAssessment: json['safety_assessment'],
    );
  }
}

class EquipmentAssessmentService {
  static const String baseUrl = 'http://127.0.0.1:5000/assess-equipment';
//'https://731c-2402-3a80-42a2-69e5-a0a9-be3c-873b-475d.ngrok-free.app/maintain/assess-equipment';//
  Future<EquipmentAssessmentResponse> assessEquipment(EquipmentAssessmentModel equipment) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(equipment.toJson()),
      );

      if (response.statusCode == 200) {
        return EquipmentAssessmentResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to assess equipment: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error during equipment assessment: $e');
    }
  }
}

class EquipmentAssessmentScreen extends StatefulWidget {
  @override
  _EquipmentAssessmentScreenState createState() => _EquipmentAssessmentScreenState();
}

class _EquipmentAssessmentScreenState extends State<EquipmentAssessmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _maintenanceDateController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _usageFrequencyController = TextEditingController();

  EquipmentAssessmentResponse? _assessmentResponse;
  bool _isLoading = false;

  void _submitAssessment() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final equipment = EquipmentAssessmentModel(
        equipmentName: _nameController.text,
        equipmentType: _typeController.text,
        equipmentAge: int.parse(_ageController.text),
        lastMaintenanceDate: _maintenanceDateController.text,
        currentCondition: _conditionController.text,
        usageFrequency: _usageFrequencyController.text,
      );

      try {
        final response = await EquipmentAssessmentService().assessEquipment(equipment);
        setState(() {
          _assessmentResponse = response;
          _isLoading = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Assessment failed: $e')),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipment Safety Assessment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Equipment Name'),
                validator: (value) => value!.isEmpty ? 'Please enter equipment name' : null,
              ),
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(labelText: 'Equipment Type'),
                validator: (value) => value!.isEmpty ? 'Please enter equipment type' : null,
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Equipment Age'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter equipment age' : null,
              ),
              TextFormField(
                controller: _maintenanceDateController,
                decoration: InputDecoration(labelText: 'Last Maintenance Date (YYYY-MM-DD)'),
                validator: (value) => value!.isEmpty ? 'Please enter maintenance date' : null,
              ),
              TextFormField(
                controller: _conditionController,
                decoration: InputDecoration(labelText: 'Current Condition'),
                validator: (value) => value!.isEmpty ? 'Please enter current condition' : null,
              ),
              TextFormField(
                controller: _usageFrequencyController,
                decoration: InputDecoration(labelText: 'Usage Frequency'),
                validator: (value) => value!.isEmpty ? 'Please enter usage frequency' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitAssessment,
                child: _isLoading 
                  ? CircularProgressIndicator() 
                  : Text('Assess Equipment'),
              ),
              if (_assessmentResponse != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _assessmentResponse!.safetyAssessment,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}