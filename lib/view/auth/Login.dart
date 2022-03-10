

import 'package:apps/componet/color.dart';

import 'package:apps/dashbord/pannel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {


  @override
  Widget build(BuildContext context) {
    TextEditingController _emailcontroller1= TextEditingController();
    TextEditingController  _passcontroller1 = TextEditingController();

    bool isMale = true;
    bool isRememberMe = false;
    bool _obscureText = true;

    //firebase code

    signin()async{
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailcontroller1.text,
            password: _passcontroller1.text
        );
        var authdata=userCredential.user;
        if(authdata!.uid.isNotEmpty){
          Navigator.push(context, MaterialPageRoute(
            builder: (context)=>MainPage()
          ));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }



//google sign in







    return Container(
      margin: EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(



                controller: _emailcontroller1,

                decoration: InputDecoration(

                  prefixIcon: Icon(
                    Icons.email,
                    color: Palette.iconColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Email',
                  hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                obscureText: _obscureText,
                controller: _passcontroller1,



                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Palette.iconColor,

                  ),

                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.textColor1),
                    borderRadius: BorderRadius.all(Radius.circular(35.0)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'passowrd',
                  hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
                ),

              ),
            ),
            Center(
              child: FloatingActionButton(
                  elevation: 0.0,
                  child: new Icon(Icons.check),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: (){
                   signin();

                  }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isRememberMe,
                      activeColor: Palette.textColor2,
                      onChanged: (value) {
                        setState(() {
                          isRememberMe = !isRememberMe;
                        });
                      },
                    ),
                    Text("Remember me",
                        style: TextStyle(fontSize: 12, color: Palette.textColor1))
                  ],
                ),
                TextButton(
                  onPressed: (){},
                  child: Text(
                    'Forget password',
                      style: TextStyle(fontSize: 12, color: Palette.textColor1),
                  ),
                )

              ],
            ),
            SizedBox(height: 5,),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: SignInButton(
                    Buttons.Facebook,




                    onPressed: (){},

                    // Buttons.Google,
                    // onPressed: () {
                    //   _showButtonPressDialog(context, 'Google');

                  ),
                ),
                SizedBox(height: 5,),
                Column(
                  children: [
                    Padding(
                      padding:EdgeInsets.only(left: 35),
                      child: SignInButtonBuilder(
                        text: 'Sign in with Google',
                        icon: Icons.email,
                        onPressed: () {

                        },
                        highlightColor: Colors.green,
                        backgroundColor: Colors.blueGrey[700]!,
                      ),
                    ),

                  ],

                ),
                SizedBox(height: 5,),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 35),
                      child: SignInButtonBuilder(
                        text: 'Sign in with Phone',
                        textColor: Colors.black,
                        icon: Icons.add_call,
                        onPressed: (){

                        },
                        backgroundColor: Colors.amber


                      ),
                    )


                  ],
                )

              ],
            )






          ],
        ),
      ),
    );
  }

}