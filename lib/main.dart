import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //Initialize Firebase
  await FirebaseMessaging.instance.getToken();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
         return
           MaterialApp(
             title: 'Chats',
             theme: ThemeData(
               primarySwatch: Colors.amber,
               colorScheme: ColorScheme.fromSwatch().copyWith(primary:  Colors.deepPurple.shade700, secondary: Colors.pinkAccent),
               brightness: Brightness.light,
               elevatedButtonTheme: ElevatedButtonThemeData(
                 style: ElevatedButton.styleFrom(
                     elevation: 5,
                     shadowColor: Colors.lightGreen,
                     visualDensity: VisualDensity.compact,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                   //   shape: StadiumBorder()
                 )
               )
             ),
             home: StreamBuilder(
               stream: FirebaseAuth.instance.authStateChanges(),
               builder: (context, userSnapshot) {

                 if (userSnapshot.connectionState ==  ConnectionState.waiting){
                   return const SplashScreen();
                 }
                 if (userSnapshot.hasData)
                   {
                     return const ChatScreen();
                   }
                 return const AuthScreen();
               },
             ),
           );
  }
}

