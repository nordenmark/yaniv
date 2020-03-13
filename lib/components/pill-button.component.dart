import 'package:flutter/material.dart';

class PillButton extends StatefulWidget {
  final LinearGradient gradient;
  @required
  final Widget child;
  @required
  final Function onPressed;
  final double opacity;

  PillButton(
      {this.gradient: const LinearGradient(
        colors: const [Colors.white, Colors.white],
        stops: const [0.0, 1.0],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      this.child,
      this.onPressed,
      this.opacity: 1.0});

  @override
  State<StatefulWidget> createState() => new PillButtonState({});
}

class PillButtonState extends State<PillButton> {
  final LinearGradient gradient;
  @required
  final Widget child;
  @required
  final Function onPressed;
  final double opacity;

  PillButtonState({this.gradient, this.child, this.onPressed, this.opacity});

  @override
  build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Opacity(
            opacity: opacity,
            child: ClipRRect(
                borderRadius: BorderRadius.all(const Radius.circular(32.0)),
                child: Container(
                  decoration: BoxDecoration(gradient: gradient),
                  child: Center(child: child),
                ))));
  }
}
