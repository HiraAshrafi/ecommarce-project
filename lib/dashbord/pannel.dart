import 'package:apps/dashbord/productdelais.dart';
import 'package:apps/dashbord/search_screen.dart';
import 'package:apps/view/bottomNavigator.dart';
import 'package:apps/widget/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  
  // var _firestoreInstance = FirebaseFirestore.instance;
  var _firestoreInstance=FirebaseFirestore.instance;
  fetchcarouselImage()async{
    QuerySnapshot qn=await _firestoreInstance.collection('carousslider').get();
    setState(() {
      for(int i=0;i<qn.docs.length;i++){
        _carouselImages.add(
          qn.docs[i]['img']
        );
      }

    });
    return qn.docs;
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("user-data-product").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["title"],
          "product-description": qn.docs[i]["description"],
          "product-price": qn.docs[i]["price"],
          "product-img": qn.docs[i]["img"],
        });
      }
    });

    return qn.docs;
  }






  @override
  void initState() {
    // TODO: implement initState
    fetchcarouselImage();
    fetchProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent[100],
      drawer: DrawerWidget(),
      appBar: AppBar(


      ),

       body: SafeArea(
         child: Container(
           child: Column(
             children: [
               Padding(
                 padding: EdgeInsets.only(left: 20, right: 20),
                 child: TextFormField(
                   readOnly: true,
                   decoration: InputDecoration(
                     fillColor: Colors.white,
                     focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(0)),
                         borderSide: BorderSide(color: Colors.blue)),
                     enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.all(Radius.circular(0)),
                         borderSide: BorderSide(color: Colors.grey)),
                     hintText: "Search products here",
                     hintStyle: TextStyle(fontSize: 15),
                   ),
                   onTap: () => Navigator.push(context,
                       CupertinoPageRoute(builder: (_) => SearchScreen())),
                 ),
               ),
               SizedBox(height: 20,),



               AspectRatio(
                 aspectRatio: 2.5,
                 child: CarouselSlider(
                     items: _carouselImages
                         .map((item) => Padding(
                       padding: const EdgeInsets.only(left: 10, right: 10),
                       child: Container(
                         decoration: BoxDecoration(
                             image: DecorationImage(
                                 image: NetworkImage(item),
                                 fit: BoxFit.fitWidth)),
                       ),
                     ))
                         .toList(),
                     options: CarouselOptions(
                         autoPlay:true,
                         enlargeCenterPage: false,
                         height: 300,

                         viewportFraction: 0.75,
                         autoPlayInterval: Duration(seconds: 3),


                         onPageChanged: (val, carouselPageChangedReason) {
                           setState(() {
                             _dotPosition = val;
                           });
                         })),
               ),
               SizedBox(
                 height: 10,
               ),
               DotsIndicator(
                 dotsCount:
                 _carouselImages.length == 0 ? 1 : _carouselImages.length,
                 position: _dotPosition.toDouble(),
                 decorator: DotsDecorator(

                   activeColor: Colors.deepOrange,
                   color: Colors.white,
                   spacing: EdgeInsets.all(2),
                   activeSize: Size(8, 8),
                   size: Size(10, 10),
                 ),
               ),
               SizedBox(height: 15),
               Expanded(
                 child: GridView.builder(
                     scrollDirection: Axis.vertical,
                     itemCount: _products.length,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2, childAspectRatio: 1),
                     itemBuilder: (_, index) {
                       return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>DetailsPage(
                              img: _products[index]['product-img'],
                              title: _products[index]['product-name'],
                              description: _products[index]['product-description'],
                              price: _products[index]['product-price'],
                            )
                          ));
                        },
                         child: Card(
                           shape:  RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15.0),
                           ),
                           color: Colors.lime,
                           elevation: 3,
                           child: Column(
                             children: [
                               AspectRatio(
                                   aspectRatio: 2,
                                   child: Container(
                                       color: Colors.blue,
                                       child: Image.network(
                                         _products[index]["product-img"],
                                       ))),
                               Text("${_products[index]["product-name"]}"),
                               Text(
                                   "${_products[index]["product-price"].toString()}"),
                             ],
                           ),
                         ),
                       );
                     }),
               ),





             ],
           ),
         ),
       ),
       bottomNavigationBar: Bottom(),

    );
  }
}
