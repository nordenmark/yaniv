import 'package:flutter/material.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/components/yaniv-button.component.dart';
import 'package:yaniv/helpers/hex-color.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/services/firebase.service.dart';
import 'package:yaniv/services/sound.service.dart';
import 'package:yaniv/services/vibration.service.dart';

class PlayersComponent extends StatefulWidget {
  final String gameId;
  final List<Player> players;
  final List<String> playersWhoHaveCalledAssaf;
  final String playerWhoHasCalledYaniv;

  PlayersComponent(
      {this.gameId,
      this.players,
      this.playersWhoHaveCalledAssaf,
      this.playerWhoHasCalledYaniv});

  @override
  State<StatefulWidget> createState() =>
      PlayersComponentState(gameId: gameId, players: players);
}

class PlayersComponentState extends State<PlayersComponent> {
  final FirebaseService firebaseService = FirebaseService();
  final SoundService soundService = SoundService();
  final VibrationService vibrationService = VibrationService();

  final String gameId;
  final List<Player> players;
  final List<String> playersWhoHaveCalledAssaf;
  final String playerWhoHasCalledYaniv;

  PlayersComponentState(
      {this.gameId,
      this.players,
      this.playersWhoHaveCalledAssaf,
      this.playerWhoHasCalledYaniv});

  Widget _yanivButton(Player player) {
    return PillButton(
      onPressed: () {
        soundService.yaniv();
        vibrationService.vibrate();

        setState(() {
          players.firstWhere((p) => p.name == player.name).state =
              PlayerState.YANIV;
        });
      },
      child: Text('YANIV!', style: yanivButtonStyle),
      gradient:
          new LinearGradient(colors: [Colors.blue[500], Colors.blue[700]]),
    );
  }

  _playerRow(Player player) {
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            child: Text(player.points.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ),
          Expanded(
              child: Row(children: [
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Image(image: new AssetImage('assets/game-thumb.png')),
            ),
            Text(player.name, style: TextStyle(fontSize: 16)),
          ])),
          Container(
              width: 60,
              height: 24,
              child: YanivButton(
                player: player,
                playerWhoHasCalledYaniv: playerWhoHasCalledYaniv,
                playersWhoHaveCalledAssaf: playersWhoHaveCalledAssaf,
                onPressed: () {
                  // @TODO we only handle the yaniv case for now
                  soundService.yaniv();
                  vibrationService.vibrate();

                  setState(() {
                    players.firstWhere((p) => p.name == player.name).state =
                        PlayerState.YANIV;
                  });
                },
              ))
        ],
      ),
    );
  }

  _addPlayerRow() {
    return GestureDetector(
        child: Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Center(
              child: Text('add player +',
                  style: TextStyle(fontSize: 22, color: Colors.blue))),
        ),
        onTap: () {
          debugPrint('add player');
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(0.0),
      itemCount: players.length,
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 10.0,
        color: HexColor('#f6f8fa'),
      ),
      itemBuilder: (BuildContext context, int index) {
        Player player = players[index];

        return index < players.length - 1
            ? _playerRow(player)
            : _addPlayerRow();
      },
    );
  }
}
