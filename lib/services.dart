import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class MyFirebaseStorage{



  static  UploadTask? UploadFile(String destination, File file)
  {
    try{

      final ref=FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);

    }on FirebaseException catch(e){
      print("error occured");
      print(e);
      return null;
    }






  }



}