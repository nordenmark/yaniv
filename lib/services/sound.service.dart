import 'package:audioplayers/audio_cache.dart';

class SoundService {
  final player = AudioCache();

  SoundService() {
    player.loadAll(['yaniv.mp3', 'assaf.mp3']);
  }

  yaniv() {
    player.play('yaniv.mp3');
  }

  assaf() {
    player.play('assaf.mp3');
  }
}
