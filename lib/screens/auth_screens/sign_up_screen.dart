import 'package:dhara_sih/resources/auth_methods.dart';
import 'package:dhara_sih/reusable_widgets/custom_dropdown.dart';
import 'package:dhara_sih/reusable_widgets/reusable_scaffold.dart';
import 'package:dhara_sih/reusable_widgets/reusable_text_field.dart';
import 'package:dhara_sih/screens/main_layout_screen.dart';
import 'package:dhara_sih/screens/mainlayout.dart';
import 'package:dhara_sih/widgets/reusable_glassmorph.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Define controllers for each input field
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    // Assuming AuthMethods() and necessary user information are defined elsewhere
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _fullNameController.text,
      phone: _phoneNumberController.text,
      department: _departmentController.text
    );

    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      SnackBar(content: Text(res),);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainLayoutScreen(initialIndex: 0,)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
      showBars: false,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Space elements evenly
          children: [
            //const SizedBox(height: 16),
            const Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            GlassEffectContainer(
              borderRadius: 10,
              width: double.infinity,
              height: 530,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      "Full Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ReusableTextField(
                      controller: _fullNameController,
                      label: "Enter Your Name",
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ReusableTextField(
                      controller: _phoneNumberController,
                      label: "Enter Your Number",
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    const Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ReusableTextField(
                      controller: _passwordController,
                      label: "Enter Your Password",
                    ),
                    const SizedBox(height: 16),
                   const Text(
                      "Department",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ReusableTextField(
                      controller: _departmentController,
                      label: "Enter Your Department",
                    ),
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
                  signUpUser();
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
                  "Create Account",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // 80% of screen width
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "By signing up you agree to our ",
                    ),
                    TextSpan(
                      text: "Terms",
                      style: TextStyle(color: Colors.green),
                    ),
                    TextSpan(
                      text: " and ",
                    ),
                    TextSpan(
                      text: "Conditions of Use",
                      style: TextStyle(color: Colors.green),
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
