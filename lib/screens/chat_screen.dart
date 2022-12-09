import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold
      (
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('chats/xy0Eiy2J6zirTYZMXpLA/messages')
          .snapshots(),
      builder:(context, streamSnapshot){
        if(streamSnapshot.connectionState== ConnectionState.waiting)
          {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

        final documents= streamSnapshot.data!.docs;
        print(documents.length);
    //     return ListView.builder(
    //       itemCount: documents!.length,
    //       itemBuilder: (context, index){
    //         print(documents[index].toString());
    //         return Container(
    //             padding: EdgeInsets.all(8)
    // ,
    //           child: Text(documents![index]['text'])
    //       );
    // }
    //     );
       return  ListView(
          children: documents.map((e) => Container(
            padding: const EdgeInsets.all(8),
            child: Text(e['text']),
          )).toList(),
        );
      },),
    floatingActionButton: FloatingActionButton(
      onPressed: ()  {},
    child: Icon(Icons.add),)
    );}
}
