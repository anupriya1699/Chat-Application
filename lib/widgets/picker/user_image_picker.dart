import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function (File? pickedImage) imagePickFn; //(File pickedImage)

  const UserImagePicker(this.imagePickFn, {Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
 File? _pickedImage;
  void _pickImage() async{
    // ImagePicker.getImage(source: null);
    final picker = ImagePicker();
    final userImage = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxWidth: 150);

    setState(() {
      if(userImage!=null)
        {
          _pickedImage = File(userImage.path);
        }
    });
    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         CircleAvatar(
          radius: 40,
          backgroundImage: _pickedImage!=null? FileImage(_pickedImage!) : null,
        ),
        TextButton.icon( icon: const Icon(Icons.image),
          label: const Text('Add a profile picture'),
          onPressed: _pickImage,),
      ],
    );
  }
}
