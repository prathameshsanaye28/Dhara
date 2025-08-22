// import 'package:dhara_sih/resources/checklist_services.dart';
// import 'package:dhara_sih/screens/checklist_screen/checklist_screen.dart';
// import 'package:dhara_sih/screens/checklist_screen/image_to_text.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dhara_sih/models/checklist.dart';

// class AllChecklistsScreen extends StatefulWidget {
//   final String shiftInchargeId;

//   const AllChecklistsScreen({Key? key, required this.shiftInchargeId}) : super(key: key);

//   @override
//   _AllChecklistsScreenState createState() => _AllChecklistsScreenState();
// }

// class _AllChecklistsScreenState extends State<AllChecklistsScreen> {
//   late Future<List<Checklist>> _checklistsFuture;
//   final ChecklistServices _checklistServices = ChecklistServices();

//   @override
//   void initState() {
//     super.initState();
//     _fetchChecklists();
//   }

//   void _fetchChecklists() {
//     setState(() {
//       _checklistsFuture = _checklistServices.fetchChecklists(widget.shiftInchargeId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: const Text(
//           'My Checklists',
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add, color: Colors.white),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const ImageToTextScreen(),
//                 ),
//               ).then((_) => _fetchChecklists());
//             },
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<Checklist>>(
//         future: _checklistsFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(color: Colors.white),
//             );
//           }

//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'No Checklists Yet',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const ImageToTextScreen(),
//                         ),
//                       ).then((_) => _fetchChecklists());
//                     },
//                     child: const Text('Create New Checklist'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               Checklist checklist = snapshot.data![index];
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: GestureDetector(
//                   onTap: () {
//                     // Convert items to a newline-separated string for ChecklistPage
//                     String checklistText = checklist.items
//                         .map((item) => item['description'] ?? '')
//                         .join('\n');
                    
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ChecklistPage(
//                           checklist: checklistText, 
//                           checklistId: checklist.id ?? '',
//                         ),
//                       ),
//                     );
//                   },
//                   child: Card(
//                     color: Colors.grey[900],
//                     child: ListTile(
//                       title: Text(
//                         checklist.title,
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       subtitle: Text(
//                         checklist.timestamp.toString(),
//                         style: const TextStyle(color: Colors.grey),
//                       ),
//                       trailing: const Icon(Icons.chevron_right, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:dhara_sih/models/checklist.dart';
import 'package:dhara_sih/resources/user_provider.dart';
import 'package:dhara_sih/screens/checklist_screen/checklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dhara_sih/models/checklist.dart';
import 'package:dhara_sih/resources/user_provider.dart';
import 'package:dhara_sih/screens/checklist_screen/checklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dhara_sih/models/shiftIncharge.dart';
import 'package:dhara_sih/resources/checklist_services.dart';
import 'package:dhara_sih/screens/checklist_screen/image_to_text.dart';

class AllChecklistsScreen extends StatefulWidget {
  const AllChecklistsScreen({Key? key}) : super(key: key);

  @override
  _AllChecklistsScreenState createState() => _AllChecklistsScreenState();
}

class _AllChecklistsScreenState extends State<AllChecklistsScreen> {
  late Future<List<Checklist>> _checklistsFuture = Future.value([]); // Default initialization
  final ChecklistServices _checklistServices = ChecklistServices();

  @override
  void initState() {
    super.initState();
    _fetchChecklists();
  }

  void _fetchChecklists() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final ShiftIncharge? currentUser = userProvider.getUser;

    if (currentUser != null) {
      _checklistsFuture = _checklistServices.fetchChecklists(currentUser.id!);
    } else {
      _checklistsFuture = Future.error("No user logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'My Checklists',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ImageToTextScreen(),
                ),
              ).then((_) => setState(() {
                    _fetchChecklists();
                  }));
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Checklist>>(
        future: _checklistsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No Checklists Yet',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ImageToTextScreen(),
                        ),
                      ).then((_) => setState(() {
                            _fetchChecklists();
                          }));
                    },
                    child: const Text('Create New Checklist'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Checklist checklist = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: GestureDetector(
                  onTap: () {
                    String checklistText = checklist.items
                        .map((item) => item['description'] ?? '')
                        .join('\n');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChecklistPage(
                          checklist: checklistText,
                          checklistId: checklist.id ?? '',
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.grey[900],
                    child: ListTile(
                      title: Text(
                        checklist.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        checklist.timestamp.toString(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}