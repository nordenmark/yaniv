import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/services/firebase.service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yaniv/services/auth.service.dart';
import 'package:yaniv/shared/constants.dart';
import 'package:yaniv/shared/loading.dart';


class SignupScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SignupState();
}

class SignupState extends State<SignupScreen> {
  final FirebaseService firebaseService = FirebaseService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final AuthService _yauth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Form validation
  bool _autoValidate = false;
  String password = '';
  String email = '';
  String error = 'Enter your details below';
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Assaf! Enter a valid email!';
    else
      return null;
  }

@override
  build(BuildContext context) { return loading ? LoadingAnimation() : Scaffold(

    
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
                    error,
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
                              decoration: textInputDecoration.copyWith(hintText: 'USER NAME'),
                              onChanged: (val) {
                                setState(() => usrname = val);
                              },
                            ),*/
                            TextFormField(
                              style: new TextStyle(color: Colors.white, fontSize: 14),
                              validator: validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: textInputDecoration.copyWith(hintText: 'EMAIL'),
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              style: new TextStyle(color: Colors.white, fontSize: 14),
                              validator: (val) => val.length < 6 ? "Your password needs to be 6 chars or longer!" : null,
                              obscureText: true,
                              decoration: textInputDecoration.copyWith(hintText: 'PASSWORD'),
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
                                            setState(() => loading = true);
                                            dynamic result = await _yauth.registerEmailPass(email, password);
                                            if (result == null) {
                                                setState(() => loading = false);
                                                setState(() => error = "Assaf! Email already registered!");
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
                        ],),
                ),

            ),

          ],

        ),
        
      ])
      );
  }

}