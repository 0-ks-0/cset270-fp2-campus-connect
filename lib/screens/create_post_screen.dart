import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:campus_connect/util/text_field.dart';
import 'package:campus_connect/util/primary_button.dart';
import 'package:campus_connect/models/post.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final formKey = GlobalKey<FormState>();

  final controllerTitle = TextEditingController();
  final controllerContent = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/homepage.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5),
            ),
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
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 50,
                              spreadRadius: 20,
                            ),
                          ],
                        ),
                        child: Image.asset('assets/logo.png'),
                      ),

                      const SizedBox(height: 28),

                      const Text(
                        "Create a Post",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

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
                              value == null || value.isEmpty ? "Enter a title" : null,
                            ),
                            const SizedBox(height: 20),
                            MyTextField(
                              controller: controllerContent,
                              hintText: "Content",
                              obscureText: false,
                              suffixIcon: null,
                              validator: (value) =>
                              value == null || value.isEmpty ? "Please enter content" : null,
                            ),
                            const SizedBox(height: 20),
                            PrimaryButton(
                              onTap: () async {
                                if (formKey.currentState?.validate() ?? false) {
                                  final currentUser = FirebaseAuth.instance.currentUser;

                                  if (currentUser != null) {
                                    final userDoc = await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(currentUser.uid)
                                        .get();

                                    final username = userDoc['username'] ?? "Anonymous";

                                    final newPost = Post(
                                      id: '',
                                      title: controllerTitle.text.trim(),
                                      content: controllerContent.text.trim(),
                                      author: username,
                                      timestamp: Timestamp.now(),
                                    );

                                    Navigator.pop(context, newPost);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("User not logged in.")),
                                    );
                                  }
                                }
                              },
                              text: "Publish",
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
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
