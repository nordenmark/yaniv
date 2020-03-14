import 'package:flutter/material.dart';
import 'package:yaniv/components/pill-button.component.dart';
import 'package:yaniv/models/player.model.dart';

TextStyle yanivButtonStyle =
    TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white);

TextStyle assafButtonStyle =
    TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white);

class YanivButton extends StatelessWidget {
  final Player player;
  final List<String> playersWhoHaveCalledAssaf;
  final String playerWhoHasCalledYaniv;
  final Function onPressed;

  YanivButton(
      {this.player,
      this.playersWhoHaveCalledAssaf,
      this.playerWhoHasCalledYaniv,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return PillButton(
      onPressed: onPressed,
      child: Text('YANIV!', style: yanivButtonStyle),
      gradient:
          new LinearGradient(colors: [Colors.blue[500], Colors.blue[700]]),
    );
  }
}
