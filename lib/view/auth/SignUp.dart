import 'package:apps/componet/color.dart';
import 'package:apps/view/auth/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LogAuth extends StatefulWidget {
  const LogAuth({Key? key}) : super(key: key);

  @override
  _LogAuthState createState() => _LogAuthState();
}

class _LogAuthState extends State<LogAuth> {
  TextEditingController _emailcontroller=TextEditingController();
  TextEditingController  _passcontroller=TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  bool _obscureText = true;

  bool isRememberMe = false;



  //firebase auth code
  signup()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text,
          password: _passcontroller.text
      );
      var authdata=userCredential.user;
      if(authdata!.uid.isNotEmpty){
        Navigator.push(context, MaterialPageRoute(
          builder: (context)=>UserForm()
        ));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Padding(
            padding:const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              validator: (value){
                if(value!.isEmpty || !value.contains('@')){
                  return 'Plz Enter your valid mail';
                }
                else{
                  return null;
                }
              },
              controller: _emailcontroller,
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
            padding:const EdgeInsets.only(bottom: 8.0),
            child: TextFormField(
              obscureText:_obscureText
              ,
              controller: _passcontroller,
              validator: (value){
                if(value!.isEmpty || value.length<=12){
                  return 'your passwor so weak';
                }
                else{
                  return null;
                }
              },
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
                  signup();

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
                onPressed: () {


                },
                child: Text("Forgot Password?",
                    style: TextStyle(fontSize: 12, color: Palette.textColor1)),
              )
            ],
          )
        ],
      ),
    );
  }




}
