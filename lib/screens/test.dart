import "package:flutter/material.dart";

import "package:campus_connect/services/firestore_service.dart";

class Test extends StatefulWidget
{
  Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test>
{
  FirestoreService fs = FirestoreService();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          fs.createPost("code test", "created through code", "k", null);
          fs.createPost("code test 2", "created through code", "k", DateTime.now());
        },

        child: Icon(Icons.add),
      ),
    );
  }
}
