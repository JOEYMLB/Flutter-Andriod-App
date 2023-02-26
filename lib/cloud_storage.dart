// ignore_for_file: avoid_print

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? imageFile;

  var storageRef = FirebaseStorage.instance.ref();
  
  // Stream<DocumentSnapshot> provideDocuemntFieldStream(){
  //   return FirebaseFirestore.instance.collection('UncwPOIS').doc().snapshots();
  // }

  @override 
  void initState(){
    super.initState();
    _getFileUrl();
  }

  void _getFileUrl() async{
    try{
      ListResult result = await storageRef.child('images').listAll();
      for (Reference ref in result.items){
        print(ref.name);
        if (ref.name.startsWith("${FirebaseAuth.instance.currentUser!.uid}")){
          imageFile = await ref.getDownloadURL();
          setState(() {});
        } 
      } 
    }
    on FirebaseAuthException catch (e){
      print("Couldn't download profile picture for user");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: [
          if(imageFile == null) const Icon(Icons.account_circle,size:72),
          if(imageFile != null) Image.network(imageFile!,width:125),Text("Welcome back! Click on the favorites button to browse saved POIS, or update profile picture!",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.teal),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () => _getImage(ImageSource.camera), child: const Text("Camera")),
              ElevatedButton(onPressed: () => _getImage(ImageSource.gallery), child: const Text("Gallery")),
              ElevatedButton(onPressed: (){},child:  const Text("Favorites"),)
              
            ],
          )
        ],
      ),
    );
  }
  _getImage(ImageSource source) async{
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null){
      print(image.path);
      
      String fileExtension = '';
      int period = image.path.lastIndexOf('.');
      if (period > -1){
        fileExtension = image.path.substring(period);
      }

      final profileImageRef = storageRef.child(
        "images/${FirebaseAuth.instance.currentUser!.uid}$fileExtension");

        try{
          await profileImageRef.putFile(File(image.path));
          imageFile = await profileImageRef.getDownloadURL();
          setState(() {
            
          });
        }
        on FirebaseAuthException catch (e){
          print("Couldn't upload picture. Error:$e");
        }
    }
  }
}