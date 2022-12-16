import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String _message;
  final String _userName;
  final String _userImage;
  final bool isMe;

  const MessageBubble(this._message,this._userName,this._userImage, this.isMe, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius_12=  Radius.circular(12);
    const radius_0 = Radius.circular(0);
    return Stack(
      clipBehavior: Clip.none,
      children: [ Row(
        mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMe? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: radius_12,
                topRight: radius_12,
                bottomRight:  isMe? radius_0 : radius_12,
                bottomLeft: !isMe? radius_0 : radius_12
            ),
           ),
            width: 160,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 8
            ),
            child: Column(
              crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // FutureBuilder<DocumentSnapshot>(
                //   future: FirebaseFirestore.instance.collection('users').doc(_userId).get(),
                //   builder: (context, snapshot) {
                //     if(snapshot.connectionState== ConnectionState.waiting){
                //       return Text( 'Loading...', style: TextStyle(color: Theme.of(context).primaryColor,));
                //     }
                //     return ...;)
                Text( _userName,
                style: TextStyle(fontWeight: FontWeight.bold, color: isMe? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary),
                textAlign: isMe? TextAlign.end : TextAlign.start,),
                Text(_message, style: const TextStyle(color: Colors.white),),
              ],
            )
          ),
          ],
      ),
      Positioned(
        top: -4,
          left: isMe? null : 130,
          right: isMe? 130 : null,
          child: CircleAvatar(radius: 22,
          backgroundImage: NetworkImage(_userImage),))
      ],
    );
  }
}
