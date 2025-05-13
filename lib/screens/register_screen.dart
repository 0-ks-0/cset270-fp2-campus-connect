import "package:flutter/material.dart";

import "package:campus_connect/util/text_field.dart";
import "package:campus_connect/util/primary_button.dart";

import "package:campus_connect/screens/login_screen.dart";
import "package:campus_connect/services/auth_service.dart";


class SignUpPage extends StatefulWidget
{
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
{
  final formKey = GlobalKey<FormState>();

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPasswordConfirm = TextEditingController();
  final controllerUsername = TextEditingController();


  bool passwordIsObscure = true;
  bool passwordConfirmIsObscure = true;

  String errorMessage = "";

  // Toggle password visibility
  void togglePasswordVisibility()
  {
    setState(()
    {
      passwordIsObscure = !passwordIsObscure;
    });
  }

  // Toggle password visibility
  void togglePasswordConfirmVisibility()
  {
    setState(()
    {
      passwordConfirmIsObscure = !passwordConfirmIsObscure;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,

            spacing: 28,

            children: [
              // Header
              Text(
                "Create an account",

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
              ),

              // Form
              Form(
                key: formKey,

                child: Column(
                  spacing: 20,

                  children: [
                    // Email input
                    MyTextField(
                      controller: controllerEmail,

                      hintText: "Enter your email address",
                      obscureText: false,

                      suffixIcon: null,

                      validator: (value)
                      {
                        if (value == null || value.isEmpty)
                        {
                          return "Please enter your email";
                        }

                        String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$";
                        RegExp regex = RegExp(pattern);

                        if (!regex.hasMatch(value))
                        {
                          return "Please enter a valid email";
                        }

                        return null;
                      },
                    ),

                    // Username input
                    MyTextField(
                      controller: controllerUsername,
                      hintText: "Enter your username",
                      obscureText: false,
                      suffixIcon: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a username";
                        }
                        return null;
                      },
                    ),

                    // Password input
                    MyTextField(
                      controller: controllerPassword,

                      hintText: "Enter your password",
                      obscureText: passwordIsObscure,

                      suffixIcon: IconButton(
                        onPressed: togglePasswordVisibility,
                        icon: Icon(
                          passwordIsObscure ? Icons.visibility : Icons.visibility_off
                        ),
                      ),

                      validator: (value)
                      {
                        if (value == null || value.isEmpty)
                        {
                          return "Please enter your password";
                        }

                        if (controllerPassword.text != controllerPasswordConfirm.text)
                        {
                          errorMessage += "Passwords do not match";
                          return "Passwords do not match";
                        }

                        return null;
                      },
                    ),

                    // Confirm password input
                    MyTextField(
                      controller: controllerPasswordConfirm,

                      hintText: "Enter your password again",
                      obscureText: passwordConfirmIsObscure,

                      suffixIcon: IconButton(
                        onPressed: togglePasswordConfirmVisibility,
                        icon: Icon(
                          passwordConfirmIsObscure ? Icons.visibility : Icons.visibility_off
                        ),
                      ),

                      validator: (value)
                      {
                        if (value == null || value.isEmpty)
                        {
                          return "Please enter your password";
                        }

                        if (controllerPassword.text != controllerPasswordConfirm.text)
                        {
                          errorMessage += "Passwords do not match";
                          return "Passwords do not match";
                        }

                        return null;
                      },
                    ),

                    // Sign up button
                    PrimaryButton(
                      onTap: () async {
                        if (formKey.currentState == null) {
                          return;
                        }

                        // Validate the form
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        // Get user input
                        final username = controllerUsername.text.trim();
                        final email = controllerEmail.text.trim();
                        final password = controllerPassword.text.trim();

                        AuthService authService = AuthService();

                        authService.register(context, email, password, username).then((user) {
                          if (user != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Account created successfully! Please log in."),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                                    (r) => false
                            );
                          }
                        }).catchError((error) {
                          // Show error if registration fails
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.toString()))
                          );
                        });
                      },


                      text: "Sign Up",
                    )

                  ],
                ),
              ),

              // Login link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                spacing: 6,

                children: [
                  // Already have an account
                  Text(
                    "Already have an account?",

                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  // Login Link
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },

                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
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
