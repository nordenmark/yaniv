import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/services/firebase.service.dart';
import 'package:yaniv/services/auth.service.dart';

class ForgotScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgotState();
}

class ForgotState extends State<ForgotScreen> {
  final FirebaseService firebaseService = FirebaseService();
  bool showIndicator = false;

  final AuthService _yauth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // email text field state
  bool _autoValidate = false;
  String email = '';
  String error = "We'll help you reset it and get you into the game!";
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
  build(BuildContext context) => Scaffold(
      // "resizeToAvoidBottomInset" Stops keyboard from pushing content from bottom
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: new Stack(fit: StackFit.expand, children: [
        new Image(
            fit: BoxFit.cover,
            image: new AssetImage('assets/forgot-bg.png')
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
                    image: AssetImage('assets/arrow_left.png'),
                ),
              ),
              ),

            Container(
                padding: EdgeInsets.only(top: 40, bottom: 0, left: 30, right: 30),
                child: Text(
                    "Forgot your password?",
                    style: const TextStyle(
                        color: Colors.black, 
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0,
                        fontSize: 32.0,
                    ),
                ),
            ),

            Container(
                padding: EdgeInsets.only(top: 10, bottom: 0, left: 30, right: 30),
                child: Text(
                    error,
                    style: const TextStyle(
                        color: Colors.black, 
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
                                            fillColor: const Color(0x1A333333),
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: const Color(0x4D333333),
                                                )
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: const Color(0xFF333333),
                                                )
                                            ),
                                            hintText: "EMAIL",
                                            hintStyle: TextStyle(
                                                color: Color(0xB3333333),
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1,
                                            ),
                                        ),
                                        onChanged: (val) {
                                            setState(() => email = val);
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
                                                      const Color(0xFFEFD45A), 
                                                      const Color(0xFFEFD45A)
                                                  ]
                                              ),
                                              child: new Text(
                                                  "RESET PASSWORD",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: 1,
                                                      fontSize: 12.0,
                                                      
                                                  ),
                                              ),
                                              onPressed: () async {
                                              if (_formKey.currentState.validate()) {
                                                  dynamic result = await _yauth.sendPasswordResetEmail(email);
                                                  if (result == null) {
                                                      setState(() => error = "An reset password email has been sent to the address you provided!");
                                                  }
                                              } else {
                                                setState(() => error = "Your email is not in our system!");
                                                setState(() {
                                                  _autoValidate = true;
                                                });
                                              }
                                          },
                                          ),
                                      ),
                                      
                                  ],
                              ),
                          ),

                      ),

          ],

        ),
        
      ]));

}