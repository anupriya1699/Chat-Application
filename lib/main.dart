import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    // final Future<FirebaseApp> _intialization= Firebase.initializeApp();
    // return FutureBuilder(
    //     future: _intialization,
    //     builder: (context, appSnapshot){
         return
           MaterialApp(
             title: 'Flutter Demo',
             theme: ThemeData(
               primarySwatch: Colors.blue,
             ),
             home: ChatScreen(),
           );
        // });
  }
}

