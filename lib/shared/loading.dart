import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Stack(
          fit: StackFit.expand, 
          children: [
              new Image(
                  fit: BoxFit.cover,
                  image: new AssetImage(
                      'assets/landing-backdrop.png'
                  )
              ),
              Center(
                child: SpinKitSquareCircle(
                  color: const Color(0xFFFFFFFF),
                  size: 50,
                ),
              ),
      ],
    );
  }
}