import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single game'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          developer.log('Add player');
        },
        tooltip: 'Add player',
        child: Icon(Icons.add),
      ),
    );
  }
}
