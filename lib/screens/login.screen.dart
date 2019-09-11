import 'package:firebase_auth/firebase_auth.dart';
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

  _handleLogin(BuildContext context) async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    debugPrint(googleAuth.accessToken);
    debugPrint(googleAuth.idToken);

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    debugPrint(user.toString());

    // For access later on
    firebaseService.setEmail(user.email);
    Navigator.pushNamed(context, '/games');
  }

  @override
  build(BuildContext context) => Scaffold(
        body: new Center(
            child: new RaisedButton(
          child: new Text('Sign in with google'),
          onPressed: () => _handleLogin(context),
        )),
      );
}
