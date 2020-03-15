import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/services/firebase.service.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseService firebaseService = FirebaseService();
  bool showIndicator = false;

  @override
  build(BuildContext context) => Scaffold(
      backgroundColor: Colors.blue,
      body: new Stack(fit: StackFit.expand, children: [
        new Image(
            fit: BoxFit.cover,
            image: new AssetImage('assets/landing-backdrop.png')
        ),

        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Container(
                margin: new EdgeInsets.only(top: 150.0),
                child: const Image(
                    image: AssetImage('assets/logo.png'),
                ),
            ),
            new Container(
                margin: new EdgeInsets.only(top: 60.0, left: 30, right: 30),
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 10),
                child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 18.0,
                        ),
                        hintText: 'Enter your Email',
                        hintStyle: TextStyle(
                            color: Color(0xB3FFFFFF),
                            fontSize: 12.0,
                        ),
                    ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(const Radius.circular(5.0)),
                    border: Border(
                        top: BorderSide(width: 1.0, color: Color(0x4DFFFFFF)),
                        bottom: BorderSide(width: 1.0, color: Color(0x4DFFFFFF)),
                        left: BorderSide(width: 1.0, color: Color(0x4DFFFFFF)),
                        right: BorderSide(width: 1.0, color: Color(0x4DFFFFFF)),
                    ),
                    color: Color(0x0DFFFFFF),
                ),
            ),

            new Container(
                margin: new EdgeInsets.only(top: 10.0, left: 30, right: 30),
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 8, right: 10),
                child: TextField(
                    obscureText: true,
                    style: TextStyle(
                        color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 18.0,
                        ),
                        hintText: 'Enter your Email',
                        hintStyle: TextStyle(
                            color: Color(0xB3FFFFFF),
                            fontSize: 12.0,
                        ),
                    ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(const Radius.circular(5.0)),
                    border: Border(
                        top: BorderSide(width: 1.0, color: Color(0x4DFFFFFF)),
                        bottom: BorderSide(width: 1.0, color: Color(0x4DFFFFFF)),
                        left: BorderSide(width: 1.0, color: Color(0x4DFFFFFF)),
                        right: BorderSide(width: 1.0, color: Color(0x4DFFFFFF)),
                    ),
                    color: Color(0x0DFFFFFF),
                ),
            ),

            Container(
                margin: new EdgeInsets.only(top: 0.0, left: 30, right: 30),
                padding: EdgeInsets.symmetric(vertical: 25.0),
                width: double.infinity,
                child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () => print('Login Button Pressed'),
                    padding: EdgeInsets.all(20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.white,
                    child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Color(0xFF527DAA),
                            letterSpacing: 1,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ),
            ),

          Container(
                margin: new EdgeInsets.only(top: 10.0, left: 30, right: 30),
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: Text(
                  '- OR -',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
            ),

          ],

        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            new Container(
                margin: new EdgeInsets.only(top: 0.0, left: 30, right: 30, bottom: 30.0),
                height: 60,
                child: new PillButton(
                  gradient: new LinearGradient(
                      colors: [const Color(0x4DFFFFFF), const Color(0x4DFFFFFF)]),
                  child: new Text(
                    'SIGN IN WITH GOOGLE',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _handleLogin(context),
                )),

                Container(
                margin: new EdgeInsets.only(top: 0.0, left: 30, right: 30, bottom: 40.0),
                child: GestureDetector(
                onTap: () => print('Sign Up Button Pressed'),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an Account? ',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.5,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.5,
                          fontSize: 14.0,
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
        )
      ]));
  _handleLogin(BuildContext context) async {
    setState(() {
      showIndicator = true;
    });
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

      setState(() {
        showIndicator = false;
      });

      firebaseService.setEmail(user.email);
      Navigator.pushReplacementNamed(context, '/games');
    } catch (e) {
      setState(() {
        showIndicator = false;
      });
      debugPrint(e.toString());
    }
  }
}
