import 'package:chat_app/widgets/chat/new_message.dart';
import '../widgets/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState(){
    super.initState();

    //Fired when the app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      print('foreground message title: ${message.notification!.title}');
      print('foreground message body: ${message.notification!.body}');
    });

    //Fired when the app is terminated or in the background
    FirebaseMessaging.onBackgroundMessage((message) {
      print('background message title: ${message.notification?.title}');
      print('background message: ${message.notification?.body}');
      return Future.delayed(Duration.zero); //Mock Future
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message opened');
      print(message.notification?.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          DropdownButton(icon: Icon(Icons.more_vert, color: Theme.of(context).colorScheme.primary,),
              underline: Container(),
              items: [
                DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app, color: Theme.of(context).primaryColor,),
                    const SizedBox(width: 8,),
                    const Text('Log Out')
                  ],
                ),
              )], onChanged: (itemIdentifier){
            if(itemIdentifier == 'logout'){
              FirebaseAuth.instance.signOut();
            }
              })
        ],
      ),
      body: Container(
        child: Column(
          children: const [
            Expanded(
              child: Messages(),
            ),
            NewMessage()
          ],
        )
      ),
    // floatingActionButton: FloatingActionButton(
    //   backgroundColor: Theme.of(context).colorScheme.primary,
    //   onPressed: ()  {
    //     FirebaseFirestore.instance.collection('chats/xy0Eiy2J6zirTYZMXpLA/messages')
    //         .add({'text':'This is added by the button'});
    //   },
    // child: const Icon(Icons.add),)
    );}
}
