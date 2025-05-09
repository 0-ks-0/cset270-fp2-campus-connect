import "package:flutter/material.dart";

import "package:campus_connect/util/text_field.dart";
import "package:campus_connect/util/primary_button.dart";

import "package:campus_connect/screens/login_screen.dart";

class SignUpPage extends StatefulWidget
{
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPasswordConfirm = TextEditingController();

  bool passwordIsObscure = true;
  bool passwordConfirmIsObscure = true;

  String errorMessage = "";

  // Toggle password visibility
  void togglePasswordVisibility() {
    setState(() {
      passwordIsObscure = !passwordIsObscure;
    });
  }

  // Toggle password visibility
  void togglePasswordConfirmVisibility() {
    setState(() {
      passwordConfirmIsObscure = !passwordConfirmIsObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/homepage.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Dark overlay
            Container(
              color: Colors.black.withOpacity(0.5),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 250,
                        width: 270,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              blurRadius: 50,
                              spreadRadius: 20,
                            ),
                          ],
                        ),
                        child: Image.asset('assets/logo.png'),
                      ),

                      SizedBox(height: 28),

                      // Title
                      Text(
                        "Create an account",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // Form
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            MyTextField(
                              controller: controllerEmail,
                              hintText: "Enter your email address",
                              obscureText: false,
                              suffixIcon: null,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                String pattern =
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$";
                                RegExp regex = RegExp(pattern);
                                if (!regex.hasMatch(value)) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20),

                            MyTextField(
                              controller: controllerPassword,
                              hintText: "Enter your password",
                              obscureText: passwordIsObscure,
                              suffixIcon: IconButton(
                                onPressed: togglePasswordVisibility,
                                icon: Icon(
                                  passwordIsObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                if (controllerPassword.text !=
                                    controllerPasswordConfirm.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20),

                            MyTextField(
                              controller: controllerPasswordConfirm,
                              hintText: "Enter your password again",
                              obscureText: passwordConfirmIsObscure,
                              suffixIcon: IconButton(
                                onPressed: togglePasswordConfirmVisibility,
                                icon: Icon(
                                  passwordConfirmIsObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please confirm your password";
                                }
                                if (controllerPassword.text !=
                                    controllerPasswordConfirm.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20),

                            PrimaryButton(
                              onTap: () {
                                if (formKey.currentState == null) return;

                                if (!formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  return;
                                }

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                      (r) => false,
                                );
                              },
                              text: "Sign Up",
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
