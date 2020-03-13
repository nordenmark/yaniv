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
  int _gameLength = 201;
  List<int> lengthOptions = [101, 151, 201];

  String _isNotEmpty(String value) {
    if (value.isEmpty) {
      return "Please write a name";
    }
    return null;
  }

  setGameLength(int length) {
    setState(() {
      _gameLength = length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
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
                      Text('GAME LENGTH', style: _headingStyle),
                      Expanded(
                          child: ListView(
                              children: List.generate(
                                  lengthOptions.length,
                                  (index) => RadioWrapper(
                                        value: lengthOptions[index],
                                        groupValue: _gameLength,
                                        onPressed: (value) =>
                                            setGameLength(value),
                                      )))),
                      Container(
                          width: 300,
                          height: 40,
                          child: new PillButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                var id = await _firebaseService.createNewGame(
                                    gameLength: _gameLength,
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

class RadioWrapper extends StatelessWidget {
  final Function onPressed;
  final int value;
  final int groupValue;

  RadioWrapper({this.value, this.onPressed, this.groupValue});

  @override
  build(BuildContext context) {
    return Card(
        elevation: 8,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              new Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text("Scoring limit of $value",
                        style: TextStyle(fontSize: 14)),
                    Text('Game ends when a player reaches $value points',
                        style: TextStyle(fontSize: 8))
                  ])),
              new Radio(
                value: value,
                groupValue: groupValue,
                activeColor: Colors.blue,
                onChanged: (value) {
                  onPressed(value);
                },
              )
            ],
          ),
        ));
  }
}
