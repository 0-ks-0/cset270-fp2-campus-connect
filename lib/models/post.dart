import 'package:cloud_firestore/cloud_firestore.dart';

class Post
{
  late final String _id;
  late String _title;
  late String _content;
  late final String _author;
  late Timestamp _timestamp;

  Post.fromMap(Map<String, dynamic> snapshot)
  {
    _id = snapshot["id"];
    _title = snapshot["title"];
    _content = snapshot["content"];
    _author = snapshot["author"];
    _timestamp = snapshot["timestamp"];
  }

  Map toMap()
  {
    return {
      "id": _id,
      "title": _title,
      "content": _content,
      "author": _author,
      "timestamp": _timestamp,
    };
  }
}