import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yaniv/screens/login.screen.dart';
import 'package:yaniv/screens/games.screen.dart';
import 'package:provider/provider.dart';
import 'package:yaniv/services/auth.service.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    //return games.screen.dart or login.screen.dart
    //return LoginScreen();

    if (user == null) {
      return LoginScreen();
    } else {
      return GamesScreen();
    }
  }
}