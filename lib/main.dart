import 'package:flutter/material.dart';
import 'package:yaniv/screens/game.screen.dart';
import 'package:yaniv/screens/games.screen.dart';
import 'package:yaniv/screens/login.screen.dart';
import 'package:yaniv/screens/new-game.screen.dart';
import 'package:yaniv/screens/signup.screen.dart';
import 'package:yaniv/screens/forgot.screen.dart';
import 'package:yaniv/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:yaniv/services/auth.service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
          title: 'Yaniv',
          theme: ThemeData(
            fontFamily: 'Montserrat',
            primarySwatch: Colors.blue,
          ),
          initialRoute: '/',
          routes: {
            '/games': (context) => GamesScreen(),
            '/new-game': (context) => NewGameScreen(),
            '/game': (context) => GameScreen(),
            '/signup': (context) => SignupScreen(),
            '/forgot': (context) => ForgotScreen(),
          },
        ),
    );
  }
}
