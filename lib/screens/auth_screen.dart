import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _submitAuthForm(
      String email,
      String userName,
      String password,
      File? image,
      bool isLogin,
      BuildContext ctx
      )
    async {
    UserCredential authResult;
     try {
       setState(() {
         isLoading =  true;
       });
       if (isLogin){
         authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
       }
       else{
         authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);

         final ref = FirebaseStorage.instance.ref().child('user_image').child('${authResult.user!.uid}.jpg');
         await ref.putFile(image!).whenComplete(() => null);
         final url = await ref.getDownloadURL();

         await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({'userName': userName, 'email': email, 'password': password, 'imageUrl': url});
       }
     } on FirebaseAuthException catch (error){
       String? message = 'An error occured, please check your entered credentials!';

       if (error.message!=null){
         message = error.message;
       }
       
       ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
           content: Text(message!),
         backgroundColor: Theme.of(ctx).errorColor,
       ));

       setState(() {
         isLoading = false;
       });
     } catch(error){
       print(error);

       setState(() {
         isLoading = false;
       });
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, isLoading)
    );
  }
}
