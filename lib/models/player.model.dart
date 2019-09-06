import 'package:faker/faker.dart';

class Player {
  String id;
  String name;
  int score;

  Player.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    score = json['score'];
  }

  Player.randomize() {
    id = faker.guid.guid();
    name = faker.person.firstName();
    score = random.integer(210);
  }
}
