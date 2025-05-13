import "package:flutter/material.dart";
import 'package:intl/intl.dart';


import "package:cloud_firestore/cloud_firestore.dart";

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

  void update({String? docId})
  {
    if (docId != null)
    {
      fs.updatePost(docId, "new title", "updating");
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          // fs.createPost("code test", "created through code", "k", null);
          // fs.createPost("code test 2", "created through code", "k", DateTime.now());
        },

        child: Icon(Icons.add),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: fs.getPostsStream(),
        builder: (context, snapshot)
        {
          // No posts
          // TODO prints but does not display widget
          if (!snapshot.hasData)
          {
            print("*********** no data *********");
            return Center(child:Text("no data"));
          }

          List postsList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: postsList.length,

            itemBuilder: (context, index)
            {
              // Get doc
              DocumentSnapshot doc = postsList[index];
              String docId = doc.id;

              // Get data of doc
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              String title = data["title"];
              String content = data["content"];
              DateTime dateTime = data["timestamp"].toDate();
              String formattedTimestamp = DateFormat("MM-dd-yyyy hh:mm").format(dateTime);
              String userId = data["author"];

              // Display data
              return Column(
                children: [
                  Text(title),
                  Text(content),
                  Text(formattedTimestamp),
                  Text(userId),
                  IconButton(onPressed: () => update(docId: docId), icon: Icon(Icons.edit)),
                  IconButton(onPressed: () => fs.deletePost(docId), icon: Icon(Icons.delete)),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
