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
        child: Padding(
            padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextFormField(
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Player name',
                labelText: 'Name',
              ),
              onFieldSubmitted: (String name) {
                firebaseService.addPlayerToGame(gameId, name);
              },
            )));
  }
}
