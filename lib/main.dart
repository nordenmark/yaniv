import 'package:flutter/material.dart';
import 'package:yaniv/screens/game.screen.dart';
import 'package:yaniv/screens/games.screen.dart';
import 'package:yaniv/screens/login.screen.dart';
import 'package:yaniv/screens/new-game.screen.dart';
import 'package:yaniv/screens/signup.screen.dart';
import 'package:yaniv/screens/forgot.screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Yaniv',
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/games': (context) => GamesScreen(),
          '/new-game': (context) => NewGameScreen(),
          '/game': (context) => GameScreen(),
          '/signup': (context) => SignupScreen(),
          '/forgot': (context) => ForgotScreen(),
        });
  }
}
