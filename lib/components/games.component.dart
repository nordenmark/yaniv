import 'package:flutter/material.dart';
import 'package:yaniv/components/pill-button.component.dart';

import 'package:yaniv/models/game.model.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/screens/game.screen.dart';
import 'package:intl/intl.dart';

TextStyle gameNameStyle =
    new TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
TextStyle playerHeadingStyle =
    new TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
TextStyle rematchStyle = new TextStyle(
    fontSize: 11, fontWeight: FontWeight.w400, color: Colors.white);

class GamesComponent extends StatelessWidget {
  GamesComponent({this.games});

  final List<Game> games;

  Text _playersToListTitle(List<Player> players) {
    if (players.length == 0) {
      return Text('No players added...',
          style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.normal,
              color: const Color(0xFF6C7B8A)));
    }

    String title = players.map((Player player) {
      return player.name;
    }).join(', ');

    return Text(
      title,
      style: TextStyle(fontSize: 12, color: Colors.grey),
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
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 30),
      itemCount: games.length,
      //separatorBuilder: (BuildContext context, int index) => const Divider(height: 0,),
      itemBuilder: (BuildContext context, int index) {
        Game game = games[index];

        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/row-background.png'),
          )),
          padding:
              const EdgeInsets.only(top: 0, bottom: 0, right: 30, left: 30),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              new Container(
                  width: 60,
                  height: 70,
                  padding: new EdgeInsets.only(right: 0),
                  child: new ClipRRect(
                      borderRadius:
                          BorderRadius.all(const Radius.circular(10.0)),
                      child: Image(
                        image: new AssetImage('assets/game-thumb.png'),
                        fit: BoxFit.cover,
                      ))),
              new Expanded(
                  child: new ClipRRect(
                      borderRadius:
                          BorderRadius.all(const Radius.circular(10.0)),
                      child: new Container(
                          padding: new EdgeInsets.only(
                              top: 25, bottom: 25, left: 20, right: 15),
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                new GestureDetector(
                                    onTap: () =>
                                        _handleTappedGame(context, game),
                                    child: new Padding(
                                        padding: EdgeInsets.only(bottom: 2),
                                        child: Text(
                                          game.name,
                                          style: new TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.5,
                                          ),
                                        ))),
                                new Text(
                                  new DateFormat('yMMMMd')
                                      .format(game.createdAt.toDate()),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      color: const Color(0xFF6C7B8A)),
                                ),
                                new Container(
                                    padding: EdgeInsets.only(bottom: 0, top: 8),
                                    child: new Text(
                                      'Players',
                                      style: new TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    )),
                                _playersToListTitle(game.players)
                              ])))),
              new Column(children: [
                new Container(
                    margin: new EdgeInsets.only(top: 0),
                    width: 90,
                    height: 40,
                    child: new PillButton(
                      onPressed: () {
                        debugPrint('Not implemented yet');
                      },
                      child: new Text('REMATCH',
                          style: new TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              color: const Color(0xFFFFFFFF))),
                      gradient: new LinearGradient(colors: [
                        const Color(0xFF5A7BEF),
                        const Color(0xFF4048EF)
                      ]),
                    ))
              ]),
            ],
          ),
        );
      },
    );
  }
}
