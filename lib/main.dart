// import 'package:dhara_sih/firebase_options.dart';
// import 'package:dhara_sih/models/boxes.dart';
// import 'package:dhara_sih/models/shift_log.dart';
// import 'package:dhara_sih/providers/navigation_provider.dart';
// import 'package:dhara_sih/resources/user_provider.dart';
// import 'package:dhara_sih/screens/auth_screens/login_screen.dart';
// import 'package:dhara_sih/screens/home_screen/home_screen.dart';
// import 'package:dhara_sih/screens/main_layout_screen.dart';
// import 'package:dhara_sih/screens/mainlayout.dart';
// import 'package:dhara_sih/screens/splash_screen/splash_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:rive/rive.dart' as rive;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Initialize bindings
//   await rive.RiveFile.initialize();
//   await Firebase.initializeApp();
//   await Hive.initFlutter();
//   Hive.registerAdapter(ShiftLogAdapter());
//   testBox = await Hive.openBox<ShiftLog>('testBox');
//   //Printing.init();
//   // Check if the box is already open
//   // if (!Hive.isBoxOpen('shiftlogs_new')) {
//   //   print('Opening shiftlogs_new box in main...');
//   //   try {
//   //     await Hive.openBox<ShiftLog>('shiftlogs_new');
//   //   } catch (e) {
//   //     print('Error opening shiftlogs_new box: $e');
//   //   }
//   // } else {
//   //   print('shiftlogs_new box is already open in main.');
//   // }

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   static const platform = MethodChannel('com.example.sih_dhara/power_button');
  
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => NavigationProvider()),
//         ChangeNotifierProvider(
//           create: (_) => UserProvider(),
//         ),

//       ],
//       child: MaterialApp(
//         title: 'Dhara',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         debugShowCheckedModeBanner: false,
//         home: SplashScreen(),
//       ),
//     );
//   }
// }

import 'package:dhara_sih/firebase_options.dart';
import 'package:dhara_sih/models/boxes.dart';
import 'package:dhara_sih/models/shift_log.dart';
import 'package:dhara_sih/providers/navigation_provider.dart';
import 'package:dhara_sih/resources/user_provider.dart';
import 'package:dhara_sih/screens/auth_screens/login_screen.dart';
import 'package:dhara_sih/screens/home_screen/home_screen.dart';
import 'package:dhara_sih/screens/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Rive, Firebase, and Hive
  await rive.RiveFile.initialize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  // Register and open Hive boxes
  Hive.registerAdapter(ShiftLogAdapter());
  testBox = await Hive.openBox<ShiftLog>('testBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const platform = MethodChannel('com.example.sih_dhara/power_button');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Dhara',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const InitialScreen(),
      ),
    );
  }
}

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return FutureBuilder(
      future: userProvider.refreshUserFromAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Container(
            width: 60,
            height: 60,
          
            
          
          child: CircularProgressIndicator())); // Show splash screen while loading
        }

        // Navigate based on user authentication state
        final isAuthenticated = userProvider.getUser != null;
        return isAuthenticated ? const HomeScreen() : const AnimatedLoginScreen();
      },
    );
  }
}
