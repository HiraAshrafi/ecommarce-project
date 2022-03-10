
import 'dart:io';

import 'package:apps/dashbord/pannel.dart';
import 'package:apps/dashbord/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  List<String> _country = ["Bangladesh", "India", "Pakistan", 'USA', 'UK'];
  String _selectgender = 'male';
  bool isChecked = false;
  File?file;
  final _registerFormKey = GlobalKey<FormState>();
  void _submitFormRegister(){
    final isValid = _registerFormKey.currentState!.validate();
    print(';Invalid $isValid');
  }



  TextEditingController countrycontroller = TextEditingController();
  TextEditingController birthcontroller = TextEditingController();
  TextEditingController filecontroller = TextEditingController();
  TextEditingController _namecontorller = TextEditingController();
  TextEditingController _emailcontorller = TextEditingController();
  TextEditingController _agecontorller = TextEditingController();
  TextEditingController _phonecontroller = TextEditingController();
  TextEditingController _addrescontroller = TextEditingController();
  TextEditingController _biocontroller = TextEditingController();


  FocusNode _namefoucus = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _ageFocusNode = FocusNode();
  FocusNode _addreshFocusNode = FocusNode();
  FocusNode _countryFocusNode = FocusNode();
  FocusNode _dateFocusNode = FocusNode();
  FocusNode _fileFocusNode = FocusNode();


  //firebase code

  sendUserDataToDB()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("User-data-Form");
    return _collectionRef.doc(currentUser!.email).set({
      "email":_emailcontorller.text,
      "name":_namecontorller.text,
      "phone number":_phonecontroller.text,
      "Address":_addrescontroller.text,
      "country":countrycontroller.text,
      "Age":_agecontorller.text,
      "Date of Birth":birthcontroller.text,
      "introduce":_biocontroller.text,
      "Gender":_selectgender,
      "new buyer":isChecked,
      "img":''
    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>MainPage()))).catchError((error)=>print("something is wrong. $error"));
  }


//date picker function

  Future<void> _SelectdateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime
          .now()
          .year - 20),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        birthcontroller.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

 //file picker


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'Welcome to user Form',
                  style: TextStyle(fontSize: 22, color: Colors.deepOrange),
                ),
                Text('Please Enter your all informaion',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBBBBBB),
                  ),),
                SizedBox(height: 15,),

                SizedBox(height: 10,),
                Form(
                  key: _registerFormKey,
                  child:Column(
                    children: [
                      TextFormField(
                        controller: _emailcontorller,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: ()=>FocusScope.of(context).requestFocus(_namefoucus),
                        focusNode: _emailFocusNode,
                        validator: (value){
                          if(value!.isEmpty || !value.contains('@')){
                            return 'plz Enter your valid email';
                          }
                          else{
                            return null;

                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email,
                            color: Color(0x3D6158FF),
                            size: 28,),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(20),)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),

                          hintText: 'Enter Your Email',

                        ),
                      ),

                      SizedBox(height: 10),
                      TextFormField(
                        controller: _namecontorller,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: ()=>FocusScope.of(context).requestFocus(_phoneFocusNode),
                        focusNode: _namefoucus,

                        validator: (value){
                          if(value!.isEmpty || value.length<=4){
                            return "plz Enter your full name";
                          }
                          else if(value.length>15){
                            return 'your name is so high';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.supervised_user_circle,
                            color: Color(0x3D6158FF),
                            size: 28,),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(20),)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'Enter Your name',

                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _phonecontroller,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: ()=>FocusScope.of(context).requestFocus(_addreshFocusNode),
                        focusNode: _phoneFocusNode,
                        validator: (value){
                          if(value!.isEmpty || value.length>=11){
                            return 'Plz correct number type';
                          }
                          else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone,
                            color: Color(0x3D6158FF),
                            size: 28,),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(20),)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'Enter Your phone ',


                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        controller:_addrescontroller,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: ()=>FocusScope.of(context).requestFocus(_countryFocusNode),
                        focusNode: _addreshFocusNode,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home,
                            color: Color(0x3D6158FF),
                            size: 28,),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(20),)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'Enter Your Address',

                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: countrycontroller,

                        textInputAction: TextInputAction.next,
                        onEditingComplete: ()=>FocusScope.of(context).requestFocus(_ageFocusNode),
                        focusNode: _countryFocusNode,
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                              Icons.location_off
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))

                          ),
                          hintText: "choose your Country",
                          suffixIcon: DropdownButton<String>(
                            items: _country.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                                onTap: () {
                                  setState(() {
                                    countrycontroller.text = value;
                                  });
                                },
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller:_agecontorller,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: ()=>FocusScope.of(context).requestFocus(_dateFocusNode),
                        focusNode: _ageFocusNode,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home,
                            color: Color(0x3D6158FF),
                            size: 28,),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(20),)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'Enter Your Age',

                        ),
                      ),

                      SizedBox(height: 10),
                      TextFormField(
                        controller: birthcontroller,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: ()=>FocusScope.of(context).requestFocus(_fileFocusNode),
                        focusNode: _dateFocusNode,
                        readOnly: true,
                        decoration: InputDecoration(
                          prefixIcon: IconButton(
                            onPressed: () => _SelectdateOfBirth(context),
                            icon: Icon(Icons.calendar_today,
                              size: 25,),
                          ),

                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(20),)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          hintText: 'Enter Your Date Of Birth',

                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller:_biocontroller,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home,
                            color: Color(0x3D6158FF),
                            size: 28,),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.all(Radius.circular(20),)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          hintText: 'create your BIO',

                        ),
                      ),
                      SizedBox(height: 10),







                      Text(
                        'Select a Gender',
                        style: TextStyle(fontSize: 18),
                      ),

                      ListTile(
                        title: Text('Male'),

                        leading: Radio<String>(
                          value: 'male',
                          groupValue: _selectgender,
                          onChanged: (value) {
                            setState(() {
                              _selectgender = value!;
                            });
                          },

                        ),

                      ),
                      ListTile(
                        title: Text('Female'),

                        leading: Radio<String>(
                          value: 'female',
                          groupValue: _selectgender,
                          onChanged: (value) {
                            setState(() {
                              _selectgender = value!;
                            });
                          },

                        ),

                      ),
                      Text('are your new here'),
                      CheckboxListTile(
                        title: Text('yes'),
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      SizedBox(height: 10),

                      Center(
                        child: ElevatedButton(

                          onPressed: (){
                            sendUserDataToDB();
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size(130, 100),
                              shape: const CircleBorder(
                              )
                          ),
                          child: Text('Upload',style: TextStyle(fontSize: 25),),
                        ),
                      ),
                      SizedBox(height: 10,),


                    ],
                  )

                ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
