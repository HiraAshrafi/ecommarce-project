import 'package:apps/dashbord/cart.dart';
import 'package:apps/dashbord/favourti.dart';
import 'package:apps/dashbord/profile.dart';
import 'package:flutter/material.dart';
class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int indexcurrent=0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: indexcurrent,
      onTap: (index)=>setState(()=>indexcurrent=index),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.green
        ),
        BottomNavigationBarItem(
            icon: TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>addCart()
                ));

              },
                child: Icon(Icons.add_shopping_cart)),
            label: 'cart',
            backgroundColor: Colors.teal
        ),
        BottomNavigationBarItem(

            icon: TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> AddToFav()
                ));

              },
                child: Icon(Icons.favorite)),
            label: 'favourite',
            backgroundColor: Colors.orange,

        ),
        BottomNavigationBarItem(
            icon: TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>Profile()
                ));
              },
                child: Icon(Icons.person)),
            label: 'Profile',
            backgroundColor: Colors.amberAccent
        ),
      ],
    );
  }
}
