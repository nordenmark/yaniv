import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final LinearGradient gradient;
  final Widget child;
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
  build(BuildContext context) {
    return new GestureDetector(
        onTap: onPressed,
        child: new Opacity(
            opacity: opacity,
            child: new ClipRRect(
                borderRadius: BorderRadius.all(const Radius.circular(10.0)),
                child: new Container(
                  decoration: new BoxDecoration(gradient: gradient),
                  child: new Center(child: child),
                ))));
  }
}
