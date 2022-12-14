import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
   String _enteredMessage='';

   void _sendMessage() async {
     FocusScope.of(context).unfocus();
     final user = FirebaseAuth.instance.currentUser!;
     final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
     FirebaseFirestore.instance.collection('vChat').add({
       'text': _enteredMessage,
       'createdAt': Timestamp.now(),
       'userId': user.uid,
       'userName': userData['userName'],
       'userImage': userData['imageUrl']
     });

     _controller.clear();
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                 controller: _controller,
                 textCapitalization: TextCapitalization.sentences,
                 autocorrect: true,
                 enableSuggestions: true,
                 decoration: InputDecoration(label: Text('Send a message...',
                   style: TextStyle(color: Theme.of(context).colorScheme.primary),),),
                 onChanged: (value){
                     setState(() {
                      _enteredMessage = value;
                      });
                     },
          )),
           IconButton(
             color: Theme.of(context).primaryColor,
              icon:  Icon(Icons.send, color: Theme.of(context).colorScheme.primary,),
             onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,)
        ],
      ),
    );
  }
}
