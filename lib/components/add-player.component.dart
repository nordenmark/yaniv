import 'package:flutter/material.dart';
import 'package:yaniv/services/firebase.service.dart';

class AddPlayer extends StatefulWidget {
  final String gameId;

  AddPlayer({this.gameId});

  @override
  AddPlayerState createState() => AddPlayerState(gameId: gameId);
}

class AddPlayerState extends State<AddPlayer> {
  final FirebaseService firebaseService = FirebaseService();
  final String gameId;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  AddPlayerState({this.gameId});

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 200,
        child: Form(
            key: _formKey,
            child: new Column(children: [
              new TextFormField(
                controller: nameController,
                onFieldSubmitted: (String name) {
                  firebaseService.addPlayerToGame(gameId, name);
                },
              ),
              new RaisedButton(
                child: new Text('Add player'),
                onPressed: () {
                  firebaseService.addPlayerToGame(gameId, nameController.text);
                },
              )
            ])));
  }
}
