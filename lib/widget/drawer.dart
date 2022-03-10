import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.cyan),
            child: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('User-data-Form').doc( FirebaseAuth.instance.currentUser!.email).snapshots(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                    var data=snapshot.data;
                    return CircleAvatar(
                      radius: 40,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(data['img'],
                         ),
                      ),
                    );
                  },


                ),
                SizedBox(height: 20),
                Flexible(
                  flex: 1,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('User-data-Form').doc( FirebaseAuth.instance.currentUser!.email).snapshots(),
                    builder: (BuildContext context,AsyncSnapshot snapshot){
                      var data=snapshot.data;
                      return Column(
                        children: [
                          Text(data['name'],
                            style: TextStyle(fontSize: 18,),),
                          Text(data['email'],
                            style: TextStyle(fontSize: 12,),),
                        ],
                      );
                    },


                  ),

                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          _listTitle(label: 'Home',fct: (){

          },icon: Icons.task_outlined),
          _listTitle(label: 'MyAccount',fct: (){

          },icon: Icons.task_outlined),
          _listTitle(label: 'Regiseter',fct: (){

          },icon: Icons.task_outlined),
          _listTitle(label: 'Add a Task',fct: (){

          },icon: Icons.task_outlined),
          Divider(thickness: 2),
          _listTitle(label: 'Logout',fct: (){
            _logout(context);
          },icon: Icons.task_outlined),


        ],
      ),
    );
  }
  void _logout(context){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Text(
              'Do you Want to Logout',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('NO',style: TextStyle(color: Colors.red),),
              ),
              TextButton(
                onPressed: (){
                  exit(0);
                },
                child: Text('Yes',style: TextStyle(color: Colors.green),),
              ),
            ],
          );
        }
    );
  }
  Widget _listTitle({required String label, required Function fct , required IconData icon}){
    return ListTile(
      onTap: (){
        fct();
      },
      leading: Icon(icon,color: Colors.cyan),
      title: Text(
        label,
        style: TextStyle(
            fontSize: 20,fontStyle: FontStyle.italic,color: Colors.cyan
        ),
      ),
    );
  }
}
