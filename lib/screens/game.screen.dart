import 'package:flutter/material.dart';
import 'package:yaniv/components/end-round.dialog.dart';
import 'package:yaniv/components/pill-button.component.dart';

import 'package:yaniv/components/players.component.dart';
import 'package:yaniv/helpers/hex-color.dart';
import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/services/firebase.service.dart';

class GameScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();
  final String gameId;

  GameScreen({this.gameId});

  /*
  _showDeleteConfirmation(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text(
                'Your game will be deleted forever, and forever ever.'),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                    "Delete",
                    textColor: Colors.red,
                ),
                onPressed: () async {
                    await firebaseService.deleteGame(gameId);
                    Navigator.pushNamed(context, '/games');
                },
              ),
            ],
          );
        });
  }
  */

  _getHeader() {
    return Container(
        height: 200,
        child: Stack(fit: StackFit.expand, children: [
          Image(
              fit: BoxFit.cover,
              image: new AssetImage('assets/game-background.jpeg')),
          Row(children: [Text('a')]),
        ]));
  }

  _getPlayerList() {
    return Expanded(
        child: StreamBuilder(
            stream: firebaseService.getGame(this.gameId),
            builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
              if (!snapshot.hasData) {
                return new Center(child: new CircularProgressIndicator());
              }

              Game game = snapshot.data;

              if (game.players.length == 0) {
                return Center(
                    child: Text('No players added, go ahead and add some!'));
              } else {
                return Container(
                    padding: EdgeInsets.all(18.0),
                    child: PlayersComponent(
                      players: game.players,
                      gameId: gameId,
                    ));
              }
            }));
  }

  _getFooter(BuildContext context) {
    TextStyle endGameStyle =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.red);
    LinearGradient endGameGradient =
        LinearGradient(colors: [Colors.white, Colors.white]);

    TextStyle endRoundStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white);
    LinearGradient endRoundGradient =
        LinearGradient(colors: [Colors.purple[500], Colors.blue[700]]);

    return Container(
        height: 100,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: HexColor('#eeeeee'), width: 1.0),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 160,
                child: PillButton(
                  onPressed: () {
                    debugPrint('END GAME!');
                  },
                  child: Text('END GAME', style: endGameStyle),
                  gradient: endGameGradient,
                )),
            Container(
                width: 160,
                child: PillButton(
                  onPressed: () {
                    debugPrint('gameId' + gameId);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            EndRoundDialog(gameId: gameId));
                    _showEndRoundDialog(context);
                  },
                  child: Text('END ROUND', style: endRoundStyle),
                  gradient: endRoundGradient,
                )),
          ],
        ));
  }

  _showEndRoundDialog(BuildContext context) {
    debugPrint('END ROUND!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#f6f8fa'),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_getHeader(), _getPlayerList(), _getFooter(context)]));
  }
}
