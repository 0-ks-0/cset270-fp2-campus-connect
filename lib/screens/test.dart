import "package:flutter/material.dart";

import "package:campus_connect/services/firestore_service.dart";

class Test extends StatelessWidget
{
  const Test({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: ()
          {
            FirestoreService fs = FirestoreService();
            fs.createPost("code test", "created through code", "k", null);
            fs.createPost("code test 2", "created through code", "k", DateTime.now());
          },

          child: Text("Click me")
        ),
      ),
    );
  }
}
