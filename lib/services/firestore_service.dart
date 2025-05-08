import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService
{
  var postsCollection = FirebaseFirestore.instance.collection("posts");

  /// Creates a post
  void createPost(String title, String content, DateTime timestamp, String author)
  {
    postsCollection.add({
      "title": title,
      "content": content,
      "timestamp":  Timestamp.fromDate(timestamp),
      "author": author
    });
  }
}
