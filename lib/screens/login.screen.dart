import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/services/firebase.service.dart';
import 'package:yaniv/services/auth.service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService firebaseService = FirebaseService();
  bool showIndicator = false;

  final AuthService _yauth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // email text field state
  bool _autoValidate = false;
  String email = '';
  String password = '';
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
      body: new Stack(
          fit: StackFit.expand, 
          children: [
              new Image(
                  fit: BoxFit.cover,
                  image: new AssetImage(
                      'assets/landing-backdrop.png'
                  )
              ),

              new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      new Container(
                          width: 90,
                          padding: EdgeInsets.only(
                              top: 0, 
                              bottom: 0, 
                              left: 30, 
                              right: 0
                          ),
                          margin: new EdgeInsets.only(
                              top: 75.0
                          ),
                          child: const Image(
                              image: AssetImage(
                                  'assets/yaniv-google-store.png'
                              ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  const Radius.circular(10.0)
                              ),
                          ),
                      ),

                      Container(
                          padding: EdgeInsets.only(top: 30, bottom: 0, left: 30, right: 30),
                          child: Text(
                              "Let's play Yaniv!",
                              style: const TextStyle(
                                  color: Colors.white, 
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0,
                                  fontSize: 30.0,
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
                                      TextFormField(
                                        keyboardType: TextInputType.emailAddress,
                                        validator: validateEmail,
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
                                                      const Color(0xFF5A7BEF), 
                                                      const Color(0xFF5A7BEF)
                                                  ]
                                              ),
                                              child: new Text(
                                                  "SIGN IN",
                                                  style: const TextStyle(
                                                      color: Colors.white, 
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: 1,
                                                      fontSize: 12.0,
                                                      
                                                  ),
                                              ),
                                              onPressed: () async {
                                              if (_formKey.currentState.validate()) {
                                                  dynamic result = await _yauth.signInEmailPass(email, password);
                                                  if (result == null) {
                                                      setState(() => error = "Your email and password does'nt match!");
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
                                              top:0
                                          ),
                                          child: Text(
                                              error,
                                              style: TextStyle (
                                                color: Colors.red,
                                              ),
                                          ),
                                      ),
                                  ],
                              ),
                          ),

                      ),

                      Container(
                          margin: new EdgeInsets.only(
                              left: 30, 
                              right: 30, 
                          ),
                          child: GestureDetector(
                              onTap: () {
                                  // Navigate to the second screen using a named route.
                                  Navigator.pushNamed(context, '/forgot');
                              },
                              child: RichText(
                                  text: TextSpan(
                                      children: [
                                            TextSpan(
                                                text: 'Forgot your password? ',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 0.5,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Montserrat',
                                                ),
                                          ),
                                      ],
                                  ),
                              ),
                          ),
                      ),

                      Container(
                          margin: new EdgeInsets.only(
                              top: 20.0, 
                              left: 30, 
                              right: 30, 
                              bottom: 40.0
                          ),
                          child: GestureDetector(
                              onTap: () {
                                // Navigate to the second screen using a named route.
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: RichText(
                                  text: TextSpan(
                                      children: [
                                          TextSpan(
                                              text: 'Don\'t have an Account? ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: 0.5,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Montserrat',
                                              ),
                                          ),
                                          TextSpan(
                                              text: 'Sign Up',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  letterSpacing: 0.5,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Montserrat',
                                              ),
                                          ),
                                      ],
                                  ),
                              ),
                          ),
                      )

                  ],

              ),

              new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      new Container(
                          margin: new EdgeInsets.only(
                              top: 0.0, 
                              left: 30, 
                              right: 30, 
                              bottom: 40.0
                          ),
                          height: 50,
                          child: new PillButton(
                              gradient: new LinearGradient(
                                  colors: [
                                      const Color(0x4DFFFFFF), 
                                      const Color(0x4DFFFFFF)
                                  ]
                              ),
                              child: new Text(
                                  'SIGN IN WITH GOOGLE',
                                  style: const TextStyle(
                                      color: Colors.white, 
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                      fontSize: 12.0,
                                  ),
                              ),
                              onPressed: () => _handleLogin(context),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  const Radius.circular(10.0)
                              ),
                          ),
                      ),
                  ],
              )
          ]
      )
  );

  _handleLogin(BuildContext context) async {
      setState(
          () {
              showIndicator = true;
          }
      );
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
      );
      try {
          FirebaseUser user = (
              await _auth.signInWithCredential(credential)
          ).user;

          setState(
              () {
                  showIndicator = false;
              }
          );

          firebaseService.setEmail(user.email);
          Navigator.pushReplacementNamed(context, '/games');
      } catch (e) {
          setState(
              () {
                  showIndicator = false;
              }
          );
          debugPrint(
              e.toString()
          );
      }
  }

}
