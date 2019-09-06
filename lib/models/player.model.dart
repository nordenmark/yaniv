import 'package:faker/faker.dart';

class Player {
  String id;
  String name;
  int points;

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
