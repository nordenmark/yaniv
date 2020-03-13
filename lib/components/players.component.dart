import 'package:flutter/material.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/helpers/hex-color.dart';
import 'package:yaniv/models/player.model.dart';
import 'package:yaniv/services/firebase.service.dart';
import 'package:yaniv/services/sound.service.dart';
import 'package:yaniv/services/vibration.service.dart';

TextStyle yanivButtonStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white);

class PlayersComponent extends StatelessWidget {
  PlayersComponent({this.gameId, this.players});

  final FirebaseService firebaseService = FirebaseService();
  final SoundService soundService = SoundService();
  final VibrationService vibrationService = VibrationService();
  final List<Player> players;
  final String gameId;

  // void _handleTappedPlayer(Player player, BuildContext context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (context) => Container(
  //               child: Padding(
  //             padding: EdgeInsets.only(
  //                 left: 16.0,
  //                 right: 16.0,
  //                 bottom: MediaQuery.of(context).viewInsets.bottom),
  //             child: new TextFormField(
  //               autofocus: true,
  //               keyboardType: TextInputType.number,
  //               decoration: const InputDecoration(
  //                 hintText: 'How many points?',
  //                 labelText: 'Points',
  //               ),
  //               onFieldSubmitted: (String points) {
  //                 firebaseService.addPointsToPlayer(
  //                     gameId, player.name, int.parse(points));
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           )));
  // }

  void _onTappedYanivButton(Player player) {
    debugPrint('On pressed yaniv button');
    debugPrint(player.name);
    soundService.yaniv();
    vibrationService.vibrate();
    // @TODO flashlight on and off?
    // @TODO background color animation?
  }

  void _onTappedAssafButton(Player player) {
    debugPrint('On pressed assaf button');
    soundService.assaf();
  }

  Widget _playerButtonFactory(Player player) {
    return PillButton(
      onPressed: () {
        _onTappedYanivButton(player);
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
          Container(width: 60, height: 24, child: _playerButtonFactory(player))
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
