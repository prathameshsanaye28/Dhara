import 'package:dhara_sih/resources/auth_methods.dart';
import 'package:dhara_sih/resources/user_provider.dart';
import 'package:dhara_sih/reusable_widgets/reusable_scaffold.dart';
import 'package:dhara_sih/reusable_widgets/reusable_text_field.dart';
import 'package:dhara_sih/screens/auth_screens/sign_up_screen.dart';
import 'package:dhara_sih/screens/main_layout_screen.dart';
import 'package:dhara_sih/screens/mainlayout.dart';
import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as rive;

class AnimatedLoginScreen extends StatefulWidget {
  const AnimatedLoginScreen({super.key});

  @override
  State<AnimatedLoginScreen> createState() => _AnimatedLoginScreenState();
}

class _AnimatedLoginScreenState extends State<AnimatedLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final FocusNode _passwordFocusNode =
      FocusNode(); // Track password field focus

  rive.Artboard? _loginArtboard;
  //rive.SMIInput<bool>? _eyesInput; // For controlling the eyes animation
  rive.SMIInput<bool>?
      _passwordInput; // For controlling the password typing animation

  @override
  void initState() {
    super.initState();
    _loadLoginAnimation();
    // Listen for password changes
    _passwordFocusNode.addListener(
        _onPasswordFocusChanged); // Listen for password field focus changes
  }

  // Load Rive animation and bind the controller
  Future<void> _loadLoginAnimation() async {
    try {
      final file =
          await rive.RiveFile.asset('assets/RiveAssets/login_character.riv');
      final artboard = file.mainArtboard;
      final controller =
          rive.StateMachineController.fromArtboard(artboard, 'controls');

      if (controller != null) {
        artboard.addController(controller);
        // Find the "eyes" and "password" inputs
        // _eyesInput = controller.findInput<bool>('eyes');
        _passwordInput = controller.findInput<bool>('password');

        // Set initial value for password input
        _passwordInput?.value = false;

        if (_passwordInput == null) {
          debugPrint('Password input not found in the Rive file!');
        }
      } else {
        debugPrint('State machine controller not found.');
      }

      setState(() {
        _loginArtboard = artboard;
      });
    } catch (e) {
      debugPrint('Error loading Rive animation: $e');
    }
  }

  // Update the Rive animation when password changes

  // Update password state based on focus
  void _onPasswordFocusChanged() {
    if (_passwordFocusNode.hasFocus) {
      _passwordInput?.value = true; // Set password input to true when focused
    } else {
      if (_passwordController.text.isEmpty) {
        _passwordInput?.value =
            false; // Set password input to false when not focused and empty
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

    void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == "success") {
      // Get UserProvider
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      
      // Refresh user data after successful login
      await userProvider.refreshUser();

      // Navigate to home screen
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainLayoutScreen(initialIndex: 0,),
        ),
      );
    } else {
      // Show error message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
      showBars: false,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Log In",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            Container(
              height: 150,
              child: _loginArtboard == null
                  ? const SizedBox()
                  : rive.Rive(artboard: _loginArtboard!),
            ),
            GlassEffectContainer(
              borderRadius: 10,
              width: double.infinity,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 36),
                    const Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ReusableTextField(
                      controller: _emailController,
                      label: "Enter Your Email",
                    ),
                    const SizedBox(height: 36),
                    const Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _passwordController,
                      // Pass the keyboardType to the TextField
                      focusNode: _passwordFocusNode,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize:
                            14, // Adjusted font size for better readability
                      ),
                      decoration: InputDecoration(
                        labelText: "Enter Your Password",
                        labelStyle: const TextStyle(
                            color: Colors.white54, fontSize: 14),
                        filled: true,
                        fillColor: const Color.fromRGBO(233, 234, 230, 0.17),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12), // Reduced vertical padding
                      ),
                    ),

                    // Assign focus node to the password field

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 270,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(16, 38, 4, 1),
                    Color.fromRGBO(69, 126, 15, 1)
                  ], // Gradient colors
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ElevatedButton(
                onPressed: () {
                  loginUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.transparent, // Makes button background transparent
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                ),
                child: const Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the next screen if the user taps the sign in button
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of screen width
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "New user? ",
                      ),
                      TextSpan(
                        text: "Sign in",
                        style: TextStyle(color: Colors.green),
                      ),
                      TextSpan(
                        text: " to continue.",
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
