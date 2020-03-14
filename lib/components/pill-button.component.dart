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
  State<StatefulWidget> createState() => new PillButtonState(
      gradient: this.gradient,
      child: this.child,
      onPressed: this.onPressed,
      opacity: this.opacity);
}

class PillButtonState extends State<PillButton>
    with SingleTickerProviderStateMixin {
  final LinearGradient gradient;
  @required
  final Widget child;
  @required
  final Function onPressed;
  final double opacity;

  double _scale = 1.0;
  AnimationController _controller;

  PillButtonState({this.gradient, this.child, this.onPressed, this.opacity});

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  _onTapUp(TapUpDetails details) {
    _controller.reverse();
    this.onPressed();
  }

  @override
  build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Transform.scale(
            scale: _scale,
            child: Opacity(
                opacity: opacity,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(const Radius.circular(10.0)),
                    child: Container(
                      decoration: BoxDecoration(gradient: gradient),
                      child: Center(child: child),
                    )))));
  }
}
