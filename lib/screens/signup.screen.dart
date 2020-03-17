import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/services/firebase.service.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

@override
  build(BuildContext context) => Scaffold(
      // "resizeToAvoidBottomInset" Stops keyboard from pushing content from bottom
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: new Stack(fit: StackFit.expand, children: [
        new Image(
            fit: BoxFit.cover,
            image: new AssetImage('assets/sign-in-back.png')
        ),

        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
                width:30,
                margin: new EdgeInsets.only(top: 95.0, left: 30, right: 30, bottom: 0.0),
                child: GestureDetector(
                //onTap: () => print('Forgot password Button Pressed'),
                onTap: () {
                  // Navigate to the second screen using a named route.
                  Navigator.pushNamed(context, '/');
                },
                child: const Image(
                    image: AssetImage('assets/arrow_left_white.png'),
                ),
              ),
              ),

            Container(
                padding: EdgeInsets.only(top: 40, bottom: 0, left: 30, right: 0),
                child: Text(
                    "Join the fun!",
                    style: const TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                        fontSize: 32.0,
                    ),
                ),
            ),

            Container(
                padding: EdgeInsets.only(top: 10, bottom: 0, left: 30, right: 0),
                child: Text(
                    "Enter your details below",
                    style: const TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.w200,
                        letterSpacing: 0,
                        fontSize: 16.0,
                    ),
                ),
            ),

            new Container(
                margin: new EdgeInsets.only(top: 20.0, left: 30, right: 30),
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 10),
                height: 52,
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'USER NAME',
                        hintStyle: TextStyle(
                            color: Color(0xB3FFFFFF),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                        ),
                    ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(5.0), 
                        topRight: const Radius.circular(5.0)
                    ),
                    border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                        bottom: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                        left: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                        right: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                    ),
                    color: Color(0x0DFFFFFF),
                ),
            ),

            new Container(
                margin: new EdgeInsets.only(top: 0.0, left: 30, right: 30),
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 10),
                height: 52,
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'EMAIL ADDRESS',
                        hintStyle: TextStyle(
                            color: Color(0xB3FFFFFF),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                        ),
                    ),
                ),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                        bottom: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                        left: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                        right: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                    ),
                    color: Color(0x0DFFFFFF),
                ),
            ),

            new Container(
                margin: new EdgeInsets.only(top: 0.0, left: 30, right: 30),
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 20, right: 10),
                height: 52,
                child: TextField(
                    obscureText: true,
                    style: TextStyle(
                        color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'PASSWORD',
                        hintStyle: TextStyle(
                            color: Color(0xB3FFFFFF),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                        ),
                    ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(5.0), 
                        bottomRight: const Radius.circular(5.0)
                    ),
                    border: Border(
                        top: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                        bottom: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                        left: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                        right: BorderSide(width: 1.0, color: Color(0xFFFFFFFF)),
                    ),
                    color: Color(0x0DFFFFFF),
                ),
            ),

            Container(
                margin: new EdgeInsets.only(top: 20.0, left: 30, right: 30, bottom: 20.0),
                height: 60,
                child: new PillButton(
                  gradient: new LinearGradient(
                      colors: [const Color(0xFFA573FF), const Color(0xFFA573FF)]),
                  child: new Text(
                    'CREATE ACCOUNT',
                    style: const TextStyle(
                        color: Colors.white, 
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 12.0,
                    ),
                  ),
                  onPressed: () => print('Login Button Pressed'),
                ),
            ),

          ],

        ),
        
      ]));

}