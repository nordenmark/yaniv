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
            image: new AssetImage('assets/landing-backdrop.png')),
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/logo.png'),
            ),
            new Container(
                margin: new EdgeInsets.only(top: 80.0),
                width: 300,
                height: 60,
                child: new PillButton(
                  gradient: new LinearGradient(
                      colors: [Colors.blue[400], Colors.blue[100]]),
                  child: new Text(
                    'SIGN IN WITH GOOGLE',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _handleLogin(context),
                ))
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
