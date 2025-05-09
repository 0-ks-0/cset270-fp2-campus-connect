import "package:flutter/material.dart";

import "package:campus_connect/util/text_field.dart";
import "package:campus_connect/util/primary_button.dart";

import "package:campus_connect/screens/register_screen.dart";
import "package:campus_connect/screens/home_screen.dart";

class LoginPage extends StatefulWidget
{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  bool passwordIsObscure = true;

  // Toggle password visibility
  void togglePasswordVisibility() {
    setState(() {
      passwordIsObscure = !passwordIsObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/homepage.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Dark overlay
            Container(color: Colors.black.withOpacity(0.5)),

            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
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

                      Text(
                        "Welcome back!",
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
                                icon: Icon(passwordIsObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            PrimaryButton(
                              onTap: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                        (r) => false,
                                  );
                                }
                              },
                              text: "Login",
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      // Sign-up link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
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
