import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService
{
  var postsCollection = FirebaseFirestore.instance.collection("posts");

  /// Creates a post
  void createPost(String title, String content, String author, DateTime? timestamp)
  {
    postsCollection.add({
      "title": title,
      "content": content,
      "timestamp":  timestamp == null ? Timestamp.now() : Timestamp.fromDate(timestamp),
      "author": author
    });
  }
}
