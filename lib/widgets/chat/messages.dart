import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('vChat').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, chatSnapshot){
          if(chatSnapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final  chatDocs= chatSnapshot.data!.docs;
          return ListView.builder(
              reverse:  true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index){
                // return Text(chatDocs[index]['text']??'') ;
                return MessageBubble(
                    chatDocs[index]['text']??'',
                    chatDocs[index]['userName']??'',
                    chatDocs[index]['userImage']??'',
                    chatDocs[index]['userId']== FirebaseAuth.instance.currentUser?.uid ? true : false,
                    key: ValueKey(chatDocs[index].id));
              });
        });
  }
}
