import 'package:flutter/material.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/helpers/hex-color.dart';
import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/screens/game.screen.dart';
import 'package:yaniv/services/firebase.service.dart';

TextStyle endRoundButtonStyles =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white);

class EndRoundDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final firebaseService = FirebaseService();
  final String gameId;
  final Map<String, int> reportedScores = new Map();

  EndRoundDialog({this.gameId});

  _getPlayerRow(BuildContext context, Player player) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(player.name),
          Container(
            width: 50,
            height: 30,
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(4.0),
                hintText: '0',
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(2.0),
                  borderSide: new BorderSide(),
                ),
              ),
              onSaved: (value) {
                reportedScores[player.name] =
                    value.isEmpty ? 0 : int.parse(value);
              },
              keyboardType: TextInputType.number,
              style: new TextStyle(
                fontSize: 12,
              ),
            ),
          )
        ]);
  }

  _getPlayerList() {
    debugPrint('gameId' + this.gameId);
    // return Text('A');
    return Expanded(
        child: StreamBuilder(
            stream: firebaseService.getGame(this.gameId),
            builder: (BuildContext context, AsyncSnapshot<Game> snapshot) {
              if (!snapshot.hasData) {
                return new Center(child: new CircularProgressIndicator());
              }

              Game game = snapshot.data;

              return Form(
                  key: _formKey,
                  child: ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemCount: game.players.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 10.0,
                      color: HexColor('#f6f8fa'),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return _getPlayerRow(context, game.players[index]);
                    },
                  ));
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Container(
            width: 300.0,
            padding: EdgeInsets.all(18.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Text(
                        'Round has ended, let\'s tally up the round score!'),
                  ),
                  _getPlayerList(),
                  PillButton(
                    onPressed: () {
                      _formKey.currentState.save();
                      firebaseService.addPointsToPlayers(
                          gameId, reportedScores);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameScreen(gameId: gameId),
                          ));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child:
                          Text('START NEXT ROUND', style: endRoundButtonStyles),
                    ),
                    gradient: LinearGradient(
                        colors: [Colors.blue[500], Colors.blue[700]]),
                  )
                ])));
  }
}
