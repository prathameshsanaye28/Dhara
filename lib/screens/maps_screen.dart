import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhara_sih/reusable_widgets/reusable_glassmorphic_container.dart';
import 'package:dhara_sih/reusable_widgets/reusable_scaffold.dart';
import 'package:flutter/material.dart';

// Define a model for regions
class Region {
  double left;
  double top;
  double width;
  double height;
  bool isVisible;

  Region({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    this.isVisible = false,
  });
}

class BlueprintScreen extends StatefulWidget {
  @override
  _BlueprintScreenState createState() => _BlueprintScreenState();
}

class _BlueprintScreenState extends State<BlueprintScreen> {
  String? blueprintUrl;
  List<Region> regions = []; // List of regions

  @override
  void initState() {
    super.initState();
    fetchBlueprintUrl();
    fetchRegionsFromFirestore(); // Fetch regions from Firestore
  }

  // Fetch blueprint image URL
  Future<void> fetchBlueprintUrl() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore.collection('mines').get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot document = querySnapshot.docs.first;
        setState(() {
          blueprintUrl = document['blueprint'];
        });
      }
    } catch (e) {
      print('Error fetching blueprint: $e');
    }
  }

  // Fetch regions from Firestore
  Future<void> fetchRegionsFromFirestore() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot querySnapshot = await firestore.collection('regions').get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Region> loadedRegions = [];
        for (var doc in querySnapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          loadedRegions.add(Region(
            left: data['left'] / 8.4, // Scale down to match the blueprint
            top: data['top'] / 8.4,
            width: data['width'] / 8.4,
            height: data['height'] / 8.4,
          ));
        }

        setState(() {
          regions = loadedRegions;
        });
      }
    } catch (e) {
      print('Error fetching regions: $e');
    }
  }

  // Function to check if the tap is inside any container region
  bool isTapInsideRegion(Offset tapPosition, Region region) {
    return tapPosition.dx >= region.left &&
        tapPosition.dx <= region.left + region.width &&
        tapPosition.dy >= region.top &&
        tapPosition.dy <= region.top + region.height;
  }

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
      showBars: true,
      body: Center(
        child: Column(
          children: [
            Text(
              "Blueprint Screen",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            GlassEffectContainer(
              width: double.infinity,
              height: 600,
              child: blueprintUrl == null
                  ? CircularProgressIndicator() // Show loader while fetching
                  : GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        setState(() {
                          // Iterate through all regions and check if the tap is inside any
                          for (var region in regions) {
                            if (isTapInsideRegion(
                                details.localPosition, region)) {
                              region.isVisible = !region
                                  .isVisible; // Toggle visibility of the tapped region
                            }
                          }
                        });
                      },
                      child: Stack(
                        children: [
                          Image.network(
                            blueprintUrl!,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Image is fully loaded
                              }
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Text('Failed to load image.');
                            },
                          ),
                          // Render all regions
                          for (var region in regions)
                            if (region.isVisible)
                              Positioned(
                                left: region.left,
                                top: region.top,
                                width: region.width,
                                height: region.height,
                                child: Container(
                                  color: Colors.red.withOpacity(
                                      0.5), // Red color with transparency
                                ),
                              ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}