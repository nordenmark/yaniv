import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
        body: showIndicator
            ? Center(child: CircularProgressIndicator())
            : new Center(
                child: new RaisedButton(
                child: new Text('Sign in with google'),
                onPressed: () => _handleLogin(context),
              )),
      );
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
      Navigator.pushNamed(context, '/games');
    } catch (e) {
      setState(() {
        showIndicator = false;
      });
      debugPrint(e.toString());
    }
  }
}
