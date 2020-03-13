import 'package:flutter/material.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/screens/game.screen.dart';
import 'package:yaniv/services/firebase.service.dart';

class NewGameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewGameScreenState();
}

class NewGameScreenState extends State<NewGameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firebaseService = FirebaseService();
  final _nameController = TextEditingController(text: '');

  final _headingStyle = TextStyle(fontSize: 12, letterSpacing: 1.2);

  String _isNotEmpty(String value) {
    if (value.isEmpty) {
      return "Please write a name";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(64),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'GAME NAME',
                        style: _headingStyle,
                      ),
                      TextFormField(
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 4, 16, 4),
                            hintText: 'Game name  ',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey))),
                        controller: _nameController,
                        validator: _isNotEmpty,
                      ),
                      new Text('GAME LENGTH', style: _headingStyle),
                      new Container(
                          width: 300,
                          height: 40,
                          child: new PillButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var id = await _firebaseService.createNewGame(
                                    gameLength: 201,
                                    name: _nameController.value.text);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GameScreen(gameId: id),
                                    ));
                              }
                            },
                            child: Text('Create game',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            gradient: LinearGradient(
                                colors: [Colors.blue[300], Colors.blue[500]]),
                          ))
                    ]))));
  }
}
