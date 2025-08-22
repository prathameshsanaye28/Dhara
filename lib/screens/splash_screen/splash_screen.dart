import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;

import '../../reusable_widgets/reusable_glassmorphic_container.dart';
import '../auth_screens/login_screen.dart';
import '../home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late rive.SMIInput<bool> playInput; // Controller for the Rive animation
  rive.Artboard? riveArtboard;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadRiveAnimation();
  }

  /// Loads the Rive animation and initializes the controller.
  void _loadRiveAnimation() {
    rootBundle.load('assets/RiveAssets/stone-falling.riv').then((data) async {
      final file = rive.RiveFile.import(data);
      final artboard = file.mainArtboard;

      var controller = rive.StateMachineController.fromArtboard(
        artboard,
        'State Machine 1', // Replace with your state machine name
      );
      if (controller != null) {
        artboard.addController(controller);
        playInput = controller.findInput<bool>('play')!;
        playInput.value = false; // Ensure the animation is off initially
      }

      setState(() => riveArtboard = artboard);
      _triggerAnimation();
    });
  }

  void _triggerAnimation() {
  if (riveArtboard != null && playInput != null) {
    setState(() {
      playInput.value = true; // Start the animation
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          playInput.value = false; // Stop the animation
        });

        // Correct navigation logic
        print("${_auth.currentUser}");
        final nextScreen = _auth.currentUser == null
            ?const AnimatedLoginScreen()// Navigate to login if user is not authenticated
            : const HomeScreen();        // Navigate to home if user is authenticated

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      }
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: GlassEffectContainer(
              width: double.infinity,
              height: 500,
              child: Container(
                width: 330,
                height: 330,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(233, 234, 230, 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Dhara",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          if (riveArtboard != null)
            Positioned.fill(
              child: rive.Rive(
                artboard: riveArtboard!,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}