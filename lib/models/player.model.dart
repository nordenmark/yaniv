import 'package:faker/faker.dart';

enum PlayerState { NONE, YANIV, ASSAF }

class Player {
  String id;
  String name;
  int points;
  PlayerState state = PlayerState.NONE;

  Player.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    points = json['points'];
  }

  Player.randomize() {
    id = faker.guid.guid();
    name = faker.person.firstName();
    points = random.integer(210);
  }
}
