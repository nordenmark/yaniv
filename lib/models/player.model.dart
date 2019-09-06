import 'package:faker/faker.dart';

class Player {
  String id;
  int score;

  Player.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
  }

  Player.randomize() {
    id = faker.guid.guid();
    score = random.integer(210);
  }
}
