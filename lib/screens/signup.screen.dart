import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/services/firebase.service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaniv/services/auth.service.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignupState();
}

class SignupState extends State<SignupScreen> {
  final FirebaseService firebaseService = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final AuthService _yauth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // Form validation
  bool _autoValidate = false;
  String password = '';
  String email = '';
  String error = '';
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

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
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Form(
                    autovalidate: _autoValidate,
                    key: _formKey,
                    child: Column(
                        children: <Widget>[
                            
                            // @TODO Need to look at adding username
                            /*TextFormField(
                              validator: (val) => val.isEmpty ? "Enter a username!" : null,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: 'USER NAME',
                                  hintStyle: TextStyle(
                                      color: Color(0xB3FFFFFF),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                  ),
                              ),
                              onChanged: (val) {
                                setState(() => usrname = val);
                              },
                            ),*/
                            TextFormField(
                              validator: validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: const Color(0x1AFFFFFF),
                                            filled: true,
                                enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color(0x4DFFFFFF),
                                              )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color(0xFFFFFFFF),
                                              )
                                            ),
                                  hintText: 'EMAIL ADDRESS',
                                  hintStyle: TextStyle(
                                      color: Color(0xB3FFFFFF),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                  ),
                              ),
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              validator: (val) => val.length < 6 ? "Your password needs to be 6 chars or longer!" : null,
                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: const Color(0x1AFFFFFF),
                                            filled: true,
                                enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color(0x4DFFFFFF),
                                              )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color(0xFFFFFFFF),
                                              )
                                            ),
                                  hintText: 'PASSWORD',
                                  hintStyle: TextStyle(
                                      color: Color(0xB3FFFFFF),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                  ),
                              ),
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                            ),
                            Container (
                                margin: EdgeInsets.only(
                                    top:20
                                ),
                                height: 50,
                                child: new PillButton(
                                    gradient: new LinearGradient(
                                        colors: [
                                            const Color(0xFFA573FF), 
                                            const Color(0xFFA573FF)
                                        ]
                                    ),
                                    child: new Text(
                                        "CREATE ACCOUNT",
                                        style: const TextStyle(
                                            color: Colors.white, 
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1,
                                            fontSize: 12.0,
                                            
                                        ),
                                    ),
                                    onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                            dynamic result = await _yauth.registerEmailPass(email, password);
                                            if (result == null) {
                                                setState(() => error = "Please check your information");
                                            } else {
                                              Navigator.pushNamed(context, '/');
                                            }
                                        } else {
                                          setState(() {
                                            _autoValidate = true;
                                          });
                                        }
                                    },
                                ),
                            ),
                            Container (
                                margin: EdgeInsets.only(
                                    top:20
                                ),
                                child: Text(
                                    error,
                                    style: TextStyle (
                                      color: Colors.red,
                                    ),
                                ),
                            ),
                        ],),
                ),

            ),


            /*new Container(
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
            ),*/

          ],

        ),
        
      ]));

}