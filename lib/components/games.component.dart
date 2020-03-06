import 'package:flutter/material.dart';
import 'package:yaniv/components/pill-button.component.dart';

import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/screens/game.screen.dart';
import 'package:intl/intl.dart';

TextStyle gameNameStyle =
    new TextStyle(fontSize: 16, fontWeight: FontWeight.w100);
TextStyle playerHeadingStyle =
    new TextStyle(fontSize: 11, fontWeight: FontWeight.bold);
TextStyle rematchStyle = new TextStyle(
    fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white);

class GamesComponent extends StatelessWidget {
  GamesComponent({this.games});

  final List<Game> games;

  Text _playersToListTitle(List<Player> players) {
    if (players.length == 0) {
      return Text('No players added...',
          style: TextStyle(fontStyle: FontStyle.italic));
    }

    String title = players.map((Player player) {
      return player.name;
    }).join(', ');

    return Text(
      title,
      style: TextStyle(fontSize: 11, color: Colors.grey),
    );
  }

  void _handleTappedGame(BuildContext context, Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(gameId: game.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      itemCount: games.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        Game game = games[index];

        return Container(
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Center(
                  child: new Padding(
                      padding: new EdgeInsets.all(16),
                      child: Image(
                          image: new AssetImage('assets/game-thumb.png')))),
              new Expanded(
                  child: new Padding(
                      padding: new EdgeInsets.only(left: 16, right: 16),
                      child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new GestureDetector(
                                onTap: () => _handleTappedGame(context, game),
                                child: new Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Text(
                                      game.name,
                                      style: gameNameStyle,
                                    ))),
                            new Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: new Text('Players',
                                    style: playerHeadingStyle)),
                            _playersToListTitle(game.players)
                          ]))),
              new Column(children: [
                new Text(
                    new DateFormat('yMMMMd').format(game.createdAt.toDate())),
                new Container(
                    margin: new EdgeInsets.only(top: 16),
                    width: 100,
                    height: 30,
                    child: new PillButton(
                      onPressed: () {
                        debugPrint('Not implemented yet');
                      },
                      child: new Text('REMATCH', style: rematchStyle),
                      gradient: new LinearGradient(
                          colors: [Colors.blue[500], Colors.blue[700]]),
                    ))
              ]),
            ],
          ),
        );
      },
    );
  }
}
