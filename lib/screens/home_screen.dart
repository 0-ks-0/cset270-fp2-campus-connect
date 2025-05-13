import 'package:flutter/material.dart';
import 'package:campus_connect/screens/create_post_screen.dart';
import 'package:campus_connect/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:campus_connect/services/auth_service.dart';
import 'login_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  String? currentUsername;

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  void fetchUsername() async {
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      setState(() {
        currentUsername = doc['username'];
      });
    }
  }

  void _showEditDialog(Post post) {
    final titleController = TextEditingController(text: post.title);
    final contentController = TextEditingController(text: post.content);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Edit Post'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
              const SizedBox(height: 10),
              TextFormField(controller: contentController, decoration: const InputDecoration(labelText: 'Content'), maxLines: 4),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () async {
              await FirebaseFirestore.instance.collection('posts').doc(post.id).update({
                'title': titleController.text,
                'content': contentController.text,
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deletePost(String id) async {
    await FirebaseFirestore.instance.collection('posts').doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: const Text(
          "Campus Feed",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(currentUsername ?? "Loading..."),
              accountEmail: Text(user?.email ?? ""),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.orange),
              ),
              decoration: const BoxDecoration(color: Colors.orange),
            ),

            const Spacer(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () async {
                final auth = AuthService();
                await auth.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/homepage.jpg"), fit: BoxFit.cover),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('posts').orderBy('timestamp', descending: true).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No posts found", style: TextStyle(color: Colors.white)));
              }

              final posts = snapshot.data!.docs.map((doc) => Post.fromDocumentSnapshot(doc)).toList();

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16, top: 10),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  final timestamp = DateFormat("MMM d, yyyy h:mm a").format(post.timestamp.toDate());
                  final isOwner = post.author == currentUsername;

                  return Card(
                    color: Colors.white.withOpacity(0.9),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(post.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(post.content, style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("By ${post.author}", style: const TextStyle(fontWeight: FontWeight.w500)),
                              Text(timestamp, style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                          if (isOwner) ...[
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => _showEditDialog(post),
                                  style: TextButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  child: const Text("Edit", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () => _deletePost(post.id),
                                  style: TextButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                                  child: const Text("Delete", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newPost = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostPage()),
          );

          if (newPost != null && newPost is Post) {
            await FirebaseFirestore.instance.collection('posts').add(newPost.toMap());
          }
        },
        backgroundColor: Colors.orange,
        icon: const Icon(Icons.add),
        label: const Text("Create Post"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
