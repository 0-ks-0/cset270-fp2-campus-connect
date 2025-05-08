import "package:flutter/material.dart";

import "package:campus_connect/util/primary_button.dart";

import "package:campus_connect/screens/register_screen.dart";
import "package:campus_connect/screens/login_screen.dart";

class WelcomePage extends StatelessWidget
{
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),

          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                // Logo
                Container(
                  height: 240,
                  color: Colors.blue[100],
                ),

                SizedBox(height: 40),

                // Title
                Text(
                  "Title of App",

                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                  ),

                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 8),

                // Subtitle
                Text(
                  "Subtitle of app. lorem ipsum dolor",

                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),

                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Sign up
                PrimaryButton(
                  onTap: ()
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage())
                    );
                  },

                  text: "Get Started",
                ),

                const SizedBox(height: 20),

                // Login
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
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
