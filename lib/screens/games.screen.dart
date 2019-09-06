import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class GamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of all games'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          developer.log('Create new game');
        },
        tooltip: 'Create new game',
        child: Icon(Icons.add),
      ),
    );
  }
}
