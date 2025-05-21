import "package:flutter/material.dart";
import "package:campus_connect/util/text_field.dart";
import "package:campus_connect/util/primary_button.dart";
import "package:campus_connect/screens/login_screen.dart";
import "package:campus_connect/services/auth_service.dart";

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  final controllerUsername = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPasswordConfirm = TextEditingController();

  bool passwordIsObscure = true;
  bool passwordConfirmIsObscure = true;

  String errorMessage = "";

  @override
  void dispose() {
    controllerUsername.dispose();
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerPasswordConfirm.dispose();
    super.dispose();
  }

  void togglePasswordVisibility() {
    setState(() {
      passwordIsObscure = !passwordIsObscure;
    });
  }

  void togglePasswordConfirmVisibility() {
    setState(() {
      passwordConfirmIsObscure = !passwordConfirmIsObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Create an account",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 28),

              Form(
                key: formKey,
                child: Column(
                  children: [
                    // Username
                    MyTextField(
                      controller: controllerUsername,
                      hintText: "Enter your username",
                      obscureText: false,
                      suffixIcon: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your username";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Email
                    MyTextField(
                      controller: controllerEmail,
                      hintText: "Enter your email address",
                      obscureText: false,
                      suffixIcon: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        final pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$";
                        final regex = RegExp(pattern);
                        if (!regex.hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Password
                    MyTextField(
                      controller: controllerPassword,
                      hintText: "Enter your password",
                      obscureText: passwordIsObscure,
                      suffixIcon: IconButton(
                        onPressed: togglePasswordVisibility,
                        icon: Icon(passwordIsObscure ? Icons.visibility : Icons.visibility_off),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        if (controllerPassword.text != controllerPasswordConfirm.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Confirm Password
                    MyTextField(
                      controller: controllerPasswordConfirm,
                      hintText: "Enter your password again",
                      obscureText: passwordConfirmIsObscure,
                      suffixIcon: IconButton(
                        onPressed: togglePasswordConfirmVisibility,
                        icon: Icon(passwordConfirmIsObscure ? Icons.visibility : Icons.visibility_off),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        }
                        if (controllerPassword.text != controllerPasswordConfirm.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    // Submit Button
                    PrimaryButton(
                      text: "Sign Up",
                      onTap: () async {
                        if (formKey.currentState == null) return;

                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        final username = controllerUsername.text.trim();
                        final email = controllerEmail.text.trim();
                        final password = controllerPassword.text.trim();

                        final authService = AuthService();

                        authService.register(context, email, password, username).then((user) {
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Account created successfully! Please log in.")),
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                                  (r) => false,
                            );
                          }
                        }).catchError((error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error.toString())),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?", style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
