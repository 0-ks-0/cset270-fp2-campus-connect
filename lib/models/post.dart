import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  late final String _id;
  late String _title;
  late String _content;
  late final String _author;
  late Timestamp _timestamp;

  Post({
    required String id,
    required String title,
    required String content,
    required String author,
    required Timestamp timestamp,
  })  : _id = id,
        _title = title,
        _content = content,
        _author = author,
        _timestamp = timestamp;

  Post.fromDocumentSnapshot(DocumentSnapshot doc)
      : _id = doc.id,
        _title = doc['title'],
        _content = doc['content'],
        _author = doc['author'],
        _timestamp = doc['timestamp'];

  Map<String, dynamic> toMap() {
    return {
      "title": _title,
      "content": _content,
      "author": _author,
      "timestamp": _timestamp,
    };
  }

  // Getters
  String get id => _id;
  String get title => _title;
  String get content => _content;
  String get author => _author;
  Timestamp get timestamp => _timestamp;
}
