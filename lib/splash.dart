import 'dart:async';

import 'package:apps/view/auth/desing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=>Log_Reg_Desing()
      ));

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Image.asset(
              'assets/icons/ecommarce.gif',
              height: 240,
            ),
            SizedBox(height: 10,),
            Text(
              "Welcome Flutter Apps",
              style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
            )
          ],
        ),
      ),
    );
  }


}
