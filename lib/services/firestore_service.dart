import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService
{
  /// Creates a post
  void createPost(String title, String content, DateTime timestamp, String author)
  {
    FirebaseFirestore
      .instance
      .collection("posts")
      .add({
        "title": title,
        "content": content,
        "timestamp":  Timestamp.fromDate(timestamp),
        "author": author
    });
  }
}
