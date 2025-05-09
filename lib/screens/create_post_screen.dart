import 'package:flutter/material.dart';
import 'package:campus_connect/util/text_field.dart';
import 'package:campus_connect/util/primary_button.dart';
import 'package:campus_connect/screens/login_screen.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final formKey = GlobalKey<FormState>();

  final controllerTitle = TextEditingController();
  final controllerContent = TextEditingController();
  final controllerTimestamp = TextEditingController();
  final controllerAuthor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            // Background
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/homepage.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Overlay
            Container(
              color: Colors.black.withOpacity(0.5),
            ),

            // Main Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo with glow
                      Container(
                        height: 250,
                        width: 270,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
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
                        "Create a Post",
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
                              controller: controllerTitle,
                              hintText: "Title",
                              obscureText: false,
                              suffixIcon: null,
                              validator: (value) =>
                              value == null || value.isEmpty
                                  ? "Please enter a title"
                                  : null,
                            ),

                            SizedBox(height: 20),

                            MyTextField(
                              controller: controllerContent,
                              hintText: "Content",
                              obscureText: false,
                              suffixIcon: null,
                              validator: (value) =>
                              value == null || value.isEmpty
                                  ? "Please enter content"
                                  : null,
                            ),

                            SizedBox(height: 20),

                            MyTextField(
                              controller: controllerTimestamp,
                              hintText: "Timestamp (e.g. January 1, 2025)",
                              obscureText: false,
                              suffixIcon: null,
                              validator: (value) =>
                              value == null || value.isEmpty
                                  ? "Please enter timestamp"
                                  : null,
                            ),

                            SizedBox(height: 20),

                            MyTextField(
                              controller: controllerAuthor,
                              hintText: "Your Name",
                              obscureText: false,
                              suffixIcon: null,
                              validator: (value) =>
                              value == null || value.isEmpty
                                  ? "Please enter author"
                                  : null,
                            ),

                            SizedBox(height: 20),

                            PrimaryButton(
                              onTap: () {
                                // No functionality yet
                                if (formKey.currentState?.validate() ?? false) {
                                  // Will save to DB later
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Post created!")),
                                  );
                                }
                              },
                              text: "Publish",
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      
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
