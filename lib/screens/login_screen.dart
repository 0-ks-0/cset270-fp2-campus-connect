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

class _LoginPageState extends State<LoginPage>
{
  final formKey = GlobalKey<FormState>();

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  bool passwordIsObscure = true;

  // Toggle password visibility
  void togglePasswordVisibility()
  {
    setState(()
    {
      passwordIsObscure = !passwordIsObscure;
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
                "Welcome back",

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

                        return null;
                      },
                    ),

                    // Login button
                    PrimaryButton(
                      onTap: ()
                      {
                        if (formKey.currentState == null)
                        {
                          return;
                        }

                        // Fails validation
                        if (!formKey.currentState!.validate())
                        {
                          formKey.currentState!.save();

                          return;
                        }

                        // Success
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (r) => false
                        );
                      },

                      text: "Login",
                    )
                  ],
                ),
              ),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                spacing: 6,

                children: [
                  // Don't have an account
                  Text(
                    "Don't have an account?",

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
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },

                    child: Text(
                      "Sign up",
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
        )
      ),
    );
  }
}
