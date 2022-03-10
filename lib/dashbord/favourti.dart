import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AddToFav extends StatefulWidget {


  @override
  _AddToFavState createState() => _AddToFavState();
}

class _AddToFavState extends State<AddToFav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users-favourite-items').doc(FirebaseAuth.instance.currentUser!.email).collection('items').snapshots(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text(
                    'Somteing is wrong'
                ),
              );

            }
            return ListView.builder(
              itemCount:
              snapshot==null?0:snapshot.data!.docs.length,
              itemBuilder: (_,index){
                DocumentSnapshot _documentsnapshot=
                snapshot.data!.docs[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Image.network(_documentsnapshot['product-img']),
                    title: Text(
                        "\$ ${_documentsnapshot['product-price']}"
                    ),
                    trailing: GestureDetector(
                      child: CircleAvatar(
                        child: Icon(Icons.delete),

                      ),
                      onTap: (){
                        FirebaseFirestore.instance.collection('users-favourite-items').doc(FirebaseAuth.instance.currentUser!.email).collection('items').doc(_documentsnapshot.id).delete();
                      },
                    ),
                  ),
                );

              },
            );
          },
        ),
      ),



    );
  }
}
