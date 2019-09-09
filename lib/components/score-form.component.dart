import 'package:flutter/material.dart';
import 'package:yaniv/models/player.model.dart';

class ScoreFormComponent extends StatefulWidget {
  const ScoreFormComponent({Key key, this.player}) : super(key: key);

  final Player player;

  @override
  ScoreFormComponentState createState() {
    return ScoreFormComponentState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ScoreFormComponentState extends State<ScoreFormComponent> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<ScoreFormComponent>.
  final _formKey = GlobalKey<FormState>();

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final pointsController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    pointsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("How many points did ${widget.player.name} get?"),
              TextFormField(
                controller: pointsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Points'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    debugPrint("Saving points: ${pointsController.text}");
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          )),
    );
  }
}
