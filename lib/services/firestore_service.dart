import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService
{
  var postsCollection = FirebaseFirestore.instance.collection("posts");

  /// Creates a post
  Future<void> createPost(String title, String content, String author, DateTime? timestamp)
  {
    return postsCollection.add({
      "title": title,
      "content": content,
      "timestamp":  timestamp == null ? Timestamp.now() : Timestamp.fromDate(timestamp),
      "author": author
    });
  }

  /// Get all post as a Stream
  Stream<QuerySnapshot> getPostsStream()
  {
    return postsCollection.orderBy("timestamp", descending: true).snapshots();
  }

  /// Update a post
  Future<void> updatePost(String docId, String title, String content)
  {
    return postsCollection
      .doc(docId)
      .update({
        "title": title,
        "content": content
      });
  }

  /// Delete a post
  Future<void> deletePost(String docId)
  {
    return postsCollection.doc(docId).delete();
  }
}
