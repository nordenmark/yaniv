import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  final GoogleSignIn signIn = GoogleSignIn(scopes: ['email']);

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
