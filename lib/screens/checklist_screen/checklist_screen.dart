// // // import 'package:flutter/material.dart';


// // // class ChecklistPage extends StatefulWidget {
// // //   ChecklistPage({super.key,required this.checklist});
// // //   final String checklist;

// // //   @override
// // //   _ChecklistPageState createState() => _ChecklistPageState();
// // // }

// // // class _ChecklistPageState extends State<ChecklistPage> {
// // //   String checklistText = widget.checklist;
// // //       // "MATH HOMEWORK\nPRESENTATION\nSEND INVITATION\nDANCE CLASS\nMEET SAMIRA\nPOSTER DESIGN\nLAUNDRY";
// // //   List<bool> isChecked = List.generate(widget.checklist.length, (_) => false);

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Checklist'),
// // //       ),
// // //       body: ListView.builder(
// // //         itemCount: 7,
// // //         itemBuilder: (context, index) {
// // //           return CheckboxListTile(
// // //             title: Text(checklistText.split('\n')[index]),
// // //             value: isChecked[index],
// // //             onChanged: (value) {
// // //               setState(() {
// // //                 isChecked[index] = value!;
// // //               });
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }




// // // import 'package:flutter/material.dart';

// // // class ChecklistPage extends StatefulWidget {
// // //   ChecklistPage({super.key, required this.checklist});
// // //   final String checklist;

// // //   @override
// // //   _ChecklistPageState createState() => _ChecklistPageState();
// // // }

// // // class _ChecklistPageState extends State<ChecklistPage> {
// // //   late String checklistText;
// // //   late List<bool> isChecked;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     checklistText = widget.checklist;
// // //     isChecked = List.generate(checklistText.split('\n').length, (_) => false);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Checklist'),
// // //       ),
// // //       body: ListView.builder(
// // //         itemCount: checklistText.split('\n').length,
// // //         itemBuilder: (context, index) {
// // //           return CheckboxListTile(
// // //             title: Text(checklistText.split('\n')[index]),
// // //             value: isChecked[index],
// // //             onChanged: (value) {
// // //               setState(() {
// // //                 isChecked[index] = value!;
// // //               });
// // //             },
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }



// // import 'package:dhara_sih/models/shiftIncharge.dart';
// // import 'package:dhara_sih/resources/checklist_services.dart';
// // import 'package:dhara_sih/resources/user_provider.dart';
// // import 'package:dhara_sih/widgets/custom_green_button.dart';
// // import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:rive/rive.dart' as rive;

// // class ChecklistPage extends StatefulWidget {
// //   ChecklistPage({super.key, required this.checklist});
// //   final String checklist;

// //   @override
// //   _ChecklistPageState createState() => _ChecklistPageState();
// // }

// // class _ChecklistPageState extends State<ChecklistPage> {
// //   late String checklistText;
// //   late List<bool> isPass;

// //   @override
// //   void initState() {
// //     super.initState();
// //     checklistText = widget.checklist;
// //     isPass = List.generate(checklistText.split('\n').length, (_) => false);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final ShiftIncharge? user = Provider.of<UserProvider>(context).getUser;
// //     final items = checklistText.split('\n');
// //     if (user == null) {
// //       return const Scaffold(
// //         body: Center(
// //           child: CircularProgressIndicator(),
// //         ),
// //       );
// //     }
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       appBar: AppBar(
// //           backgroundColor: Colors.transparent,
// //           title: const Text(
// //             "",
// //             style: TextStyle(
// //                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
// //           ),
// //           elevation: 0,
// //           actions: [
// //             const Icon(
// //               Icons.warning,
// //               color: Colors.red,
// //             ),
// //             const SizedBox(
// //               width: 20,
// //             ),
// //             const SizedBox(
// //               width: 20,
// //             ),
// //           ],
// //         ),
// //       body: Stack(
// //         children: [
// //           const rive.RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
// //           SingleChildScrollView(
// //             child: Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Text(
// //                     'Safety Checklist',
// //                     style: TextStyle(
// //                       fontSize: 24,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white
// //                     ),
// //                   ),
// //                   const SizedBox(height: 8),
// //                   const Text(
// //                     'Equipment and Machinery',
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.w600,
// //                       color: Colors.grey,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 16),

// //                   GlassEffectContainer(
// //                     borderRadius: 10,
// //                     height: 550,
// //                     width: double.infinity,
// //                       child: ListView.builder(
// //                         itemCount: items.length,
// //                         itemBuilder: (context, index) {
// //                           return Padding(
// //                             padding: const EdgeInsets.symmetric(vertical: 8.0),
// //                             child: Card(
// //                               color: Colors.black87,
// //                               child: ListTile(
// //                                 title: Text(
// //                                   items[index],
// //                                   style: const TextStyle(color: Colors.white),
// //                                 ),
// //                                 trailing: Row(
// //                                   mainAxisSize: MainAxisSize.min,
// //                                   children: [
// //                                     ElevatedButton(
// //                                       onPressed: () {
// //                                         setState(() {
// //                                           isPass[index] = false; // Mark as fail
// //                                         });
// //                                       },
// //                                       style: ElevatedButton.styleFrom(
// //                                         backgroundColor: Colors.red,
// //                                       ),
// //                                       child: const Text('Fail'),
// //                                     ),
// //                                     const SizedBox(width: 8),
// //                                     ElevatedButton(
// //                                       onPressed: () {
// //                                         setState(() {
// //                                           isPass[index] = true; // Mark as pass
// //                                         });
// //                                       },
// //                                       style: ElevatedButton.styleFrom(
// //                                         backgroundColor: Colors.green,
// //                                       ),
// //                                       child: const Text('Pass'),
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       ),
// //                   ),
// //                   // GestureDetector(
// //                   //   onTap: ()async{
// //                   //     await ChecklistServices().createChecklist(checklist, user!.id);
// //                   //   },
// //                   //   child: CustomGreenButton(label: "Create Checklist"))
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

import 'package:dhara_sih/models/shiftIncharge.dart';
import 'package:dhara_sih/resources/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;
import 'package:dhara_sih/models/checklist.dart';
import 'package:dhara_sih/resources/checklist_services.dart';
import 'package:dhara_sih/widgets/reusable_glassmorph.dart';

class ChecklistPage extends StatefulWidget {
  final String checklist;
  final String? checklistId;

  const ChecklistPage({
    Key? key, 
    required this.checklist, 
    this.checklistId
  }) : super(key: key);

  @override
  _ChecklistPageState createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  late List<Map<String, dynamic>> _items;
  final ChecklistServices _checklistServices = ChecklistServices();

  @override
  void initState() {
    super.initState();
    // Split checklist text into items and create a list of maps
    _items = widget.checklist.split('\n')
        .where((item) => item.trim().isNotEmpty)
        .map((item) => {
          'description': item.trim(),
          'status': null
        }).toList();
  }

  // void _updateItemStatus(int index, bool? status) {
  //   setState(() {
  //     _items[index]['status'] = status;
  //   });
  // }

  void _updateItemStatus(int index, String? status) {
  setState(() {
    _items[index]['status'] = status; // Set status as 'pass', 'fail', or null
  });
}

  // void _saveChecklist() async {
  //   try {
  //     // If checklistId is provided, update the existing checklist
  //     if (widget.checklistId != null) {
  //       await _checklistServices.updateChecklistItemStatus(
  //         widget.checklistId!, 
  //         _items
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Checklist Updated Successfully')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Cannot save - No Checklist ID')),
  //       );
  //     }
      
  //     Navigator.pop(context, true);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error saving checklist: $e')),
  //     );
  //   }
  // }

  // void _saveChecklist(String currentUserId) async {
  //   try {
  //     // If checklistId is not provided, create a new checklist
  //     if (widget.checklistId == null) {
  //       // You'll need to pass the current user's ID here
  //       final checklistId = await _checklistServices.createChecklist(
  //         Checklist(
  //           title: 'Safety Checklist', // You can customize this
  //           shiftInchargeUid: currentUserId, // Replace with actual user ID
  //           timestamp: DateTime.now(),
  //           items: _items,
  //         ),
  //         currentUserId // Shift incharge ID
  //       );
        
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('New Checklist Created Successfully')),
  //       );
  //     } else {
  //       // Update existing checklist
  //       await _checklistServices.updateChecklistItemStatus(
  //         widget.checklistId!, 
  //         _items
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Checklist Updated Successfully')),
  //       );
  //     }
      
  //     Navigator.pop(context, true);
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error saving checklist: $e')),
  //     );
  //   }
  // }

  void _saveChecklist(String currentUserId) async {
  try {
    // If checklistId is not provided, create a new checklist
    if (widget.checklistId == null) {
      final checklistId = await _checklistServices.createChecklist(
        Checklist(
          title: 'Safety Checklist',
          shiftInchargeUid: currentUserId,
          timestamp: DateTime.now(),
          items: _items,
        ),
        currentUserId
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New Checklist Created Successfully')),
      );
    } else {
      // Update existing checklist
      await _checklistServices.updateChecklistItemStatus(
        currentUserId,
        widget.checklistId!, 
        _items
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checklist Updated Successfully')),
      );
    }
    
    Navigator.pop(context, true);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error saving checklist: $e')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final ShiftIncharge? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Safety Checklist',
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold, 
            color: Colors.white
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: (){
              _saveChecklist(user?.id??'');
            },
          ),
        ],
        elevation: 0,
      ),
      body: Stack(
        children: [
          const rive.RiveAnimation.asset("assets/RiveAssets/bg-blur.riv"),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  GlassEffectContainer(
                    height: 500,
                    borderRadius: 10,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0, 
                            horizontal: 12.0
                          ),
                          child: Card(
                            color: Colors.black87,
                            child: ListTile(
                              title: Text(
                                _items[index]['description'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _updateItemStatus(index, 'false'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _items[index]['status'] == 'false' 
                                        ? Colors.red.shade900 
                                        : Colors.red,
                                    ),
                                    child: const Text('Fail'),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () => _updateItemStatus(index, 'true'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _items[index]['status'] == 'true' 
                                        ? Colors.green.shade900 
                                        : Colors.green,
                                    ),
                                    child: const Text('Pass'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


