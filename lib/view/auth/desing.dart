
import 'package:apps/componet/color.dart';
import 'package:flutter/material.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

import 'Login.dart';
import 'SignUp.dart';

class Log_Reg_Desing extends StatefulWidget {
  const Log_Reg_Desing({Key? key}) : super(key: key);

  @override
  _Log_Reg_DesingState createState() => _Log_Reg_DesingState();
}

class _Log_Reg_DesingState extends State<Log_Reg_Desing> {
  bool isSignupScreen = false;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.jpg"),
                  fit: BoxFit.fill

                )
              ),
              child: Container(
                padding: EdgeInsets.only(top: 90,left: 20),
                color: Color(0xFF3b5999).withOpacity(0.60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Welcome To",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow[700]
                        ),
                        children: [
                          TextSpan(
                            text:  isSignupScreen?" Ashrafi":"Back",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow[700]
                            )
                          )
                        ]
                      ),



                    ),
                    SizedBox(height: 5),
                    Text(
                        isSignupScreen?
                            "Signup To continue":
                            "Signin To continue",
                      style: TextStyle(
                        color:Palette.backgroundColor1,
                        letterSpacing: 1,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                      ),

                    ),
                    Center(
                      child: DigitalClock(
                        is24HourTimeFormat: false,
                        areaDecoration: BoxDecoration(
                          color: Colors.blue[200]
                        ),
                      ),
                    )


                  ],
                ),

              ),
            ),
          ),
          buildBottomHalfContainer(true),
          AnimatedPositioned(
            duration: Duration(microseconds: 700),
            curve: Curves.bounceInOut,
            top: isSignupScreen ? 300:250,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 380 : 500,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isSignupScreen=false;

                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LogIn",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isSignupScreen? Palette.activeColor :
                                      Palette.textColor1
                                ),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          ),

                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child:Column(
                            children: [
                              Text(
                                "Signup",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                                ),

                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.orange,
                                )
                            ],
                          )
                        )

                      ],
                    ),
                    if (isSignupScreen) LogAuth(),
                    if (!isSignupScreen) Signup()
                  ],
                ),
              ),


            ))




        ],
      ),

    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 535 : 430,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.orange, Colors.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1))
                ]),
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          )
              : Center(),
        ),
      ),
    );
  }



}
