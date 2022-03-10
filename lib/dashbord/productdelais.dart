import 'package:apps/dashbord/profile.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'cart.dart';

class DetailsPage extends StatefulWidget {
  final String img,title,description,price;




  const DetailsPage({Key? key, required this.img, required this.title, required this.description, required this.price}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  //add to cart

  Future addtocart()async{
    final FirebaseAuth _auth=FirebaseAuth.instance;
    var currentUser=_auth.currentUser;
    CollectionReference _collectionreference=FirebaseFirestore.instance.collection
      ('new-add-cart');
    return _collectionreference.doc(currentUser!.email).collection('items').doc().set(
      {
        'product-name':widget.title,
        'product-price':widget.price,
        'product-img':widget.img


      }
    ).then((value) => print('add to cart'));

  }


  //add to favourt

  Future addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("users-favourite-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.title,
      "price": widget.price,
      "images": widget.img,
    }).then((value) => print("Added to favourite"));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor:Colors.deepOrange,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
          ),
        ),
        actions: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-favourite-items")
                  .where("title")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.data==null){
                  return Text('');
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: IconButton(
                      onPressed: (){
                        snapshot.data!.docs.length==0?addToFavourite():print('Already add ');
                      },
                     icon: snapshot.data!.docs.length==0?
                      Icon(Icons.favorite_outline,color: Colors.yellow,):
                         Icon(Icons.favorite,color: Colors.red,)
                    ),
                  ),
                );

                }
          )


        ]
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30)
          ),
          child: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.img)
                  )
                ),
              ),
              SizedBox(height: 20,),
              Text(widget.title),
              SizedBox(height: 20,),
              Text(widget.description),
              SizedBox(height: 20,),
              Text("price:${widget.price}"),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200,50), primary: Colors.deepOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)
                )),
                child: Text('Add TO Card'),
                onPressed: (){
                  addtocart();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>addCart()
                  ));




  },

              )


            ],
          ),

        ),
      ),
    );
  }
}
