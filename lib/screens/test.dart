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
            FireStoreService fs = FireStoreService();
            fs.createPost("code test", "created through code", DateTime.now(), "k");
          },

          child: Text("Click me")
        ),
      ),
    );
  }
}
