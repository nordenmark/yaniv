import 'package:vibration/vibration.dart';

class VibrationService {
  vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 2000);
    }
  }
}
