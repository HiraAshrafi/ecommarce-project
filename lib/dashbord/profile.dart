import 'dart:io';

import 'package:apps/dashbord/pannel.dart';
import 'package:apps/services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Profile extends StatefulWidget {


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File?pathfile;
  List _details=[];


//select file here
  Future SelectFile()async{
    final result=await FilePicker.platform.pickFiles(allowMultiple: false);
    if(result==null)return;
    final path=result.files.single.path!;
    setState(() {
      pathfile=File(path);
    });

  }

  //upload file
  uploadFile(){
    if(pathfile==null)return null;

    final fileName=basename(pathfile!.path);
    final destination='files/$fileName';
    MyFirebaseStorage.UploadFile(destination, pathfile!);
    setState(() {

    });

  }



  sendUserDataToDB()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("User-data-Form");
    return _collectionRef.doc(currentUser!.email).set({
     "img":pathfile
    });
  }










  @override
  Widget build(BuildContext context) {
    final fileame=pathfile!=null?basename(pathfile!.path):"No file selected";
    return Scaffold(

      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.only(top: 90),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Card(
                margin: EdgeInsets.all(30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    
                    children: [
                      SizedBox(width: 140,),
                      pathfile==null?TextButton(
                        onPressed: (){SelectFile();},
                          child: Center(child: Text('select Image'))):

                          TextButton(onPressed: (){
                            SelectFile();
                          },

                            child: Center(
                              child: CircleAvatar(
                                radius: 70,
                                backgroundImage: FileImage(pathfile!),


                              ),
                            ),
                          ),

                      SizedBox(height: 20),
                      Center(
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('User-data-Form').doc( FirebaseAuth.instance.currentUser!.email).snapshots(),
                          builder: (BuildContext context,AsyncSnapshot snapshot){
                            var data=snapshot.data;
                            return Text(data['name'],
                            style: TextStyle(fontSize: 18,),);
                          },


                          ),
                        ),

                      SizedBox(height: 10),
                      Center(
                        child: Text(
                          'About',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,color: Colors.amberAccent
                          ),

                        ),

                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('User-data-Form').doc( FirebaseAuth.instance.currentUser!.email).snapshots(),
                        builder: (BuildContext context,AsyncSnapshot snapshot){
                          var data=snapshot.data;
                          return Text(data['introduce'],
                            style: TextStyle(fontSize: 16,),);
                        },


                      ),


                      SizedBox(height: 15),
                      Divider(thickness: 1),
                      SizedBox(height: 15),
                      Text(
                        'Contact Info',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Email :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child:   StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('User-data-Form').doc( FirebaseAuth.instance.currentUser!.email).snapshots(),
                              builder: (BuildContext context,AsyncSnapshot snapshot){
                                var data=snapshot.data;
                                return Text(data['email'],
                                  style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold),);
                              },


                            ),

                            ),

                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Phone Number :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child:   StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('User-data-Form').doc( FirebaseAuth.instance.currentUser!.email).snapshots(),
                              builder: (BuildContext context,AsyncSnapshot snapshot){
                                var data=snapshot.data;
                                return Text(data['phone number'],
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),);
                              },


                            ),
                            ),

                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Gender :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child:   StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('User-data-Form').doc( FirebaseAuth.instance.currentUser!.email).snapshots(),
                              builder: (BuildContext context,AsyncSnapshot snapshot){
                                var data=snapshot.data;
                                return Text(data['Gender'],
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),);
                              },


                            ),
                          ),

                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Country :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child:   StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('User-data-Form').doc( FirebaseAuth.instance.currentUser!.email).snapshots(),
                              builder: (BuildContext context,AsyncSnapshot snapshot){
                                var data=snapshot.data;
                                return Text(data['country'],
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),);
                              },


                            ),
                          ),

                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Address :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child:   StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('User-data-Form').doc( FirebaseAuth.instance.currentUser!.email).snapshots(),
                              builder: (BuildContext context,AsyncSnapshot snapshot){
                                var data=snapshot.data;
                                return Text(data['Address'],
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),);
                              },


                            ),
                          ),

                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Age :',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child:   StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('User-data-Form').doc( FirebaseAuth.instance.currentUser!.email).snapshots(),
                              builder: (BuildContext context,AsyncSnapshot snapshot){
                                var data=snapshot.data;
                                return Text(data['Age'],
                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),);
                              },


                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 15),
                      Divider(thickness: 1),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.pink,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.call_outlined),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.pink,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.call_outlined),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.pink,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.call_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Divider(thickness: 1),
                      SizedBox(height: 100),
                      Center(
                        child: ElevatedButton(

                          onPressed: (){
                           uploadFile();

                          },
                          child: Text(
                            'Next',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),

                        ),

                    ],
                  ),
                ),
              ),





            ],
          ),
        ),
      ),



    );
  }
  }
