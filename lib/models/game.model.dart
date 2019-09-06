import 'package:faker/faker.dart';
import 'package:yaniv/models/player.model.dart';

class Game {
  String id;
  List<Player> players;
  bool completed;
  int createdAt;

  Game.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    players = json['players'].map((playerJson) => Player.fromJSON(playerJson));
    completed = json['completed'];
    createdAt = json['createdAt'];
  }

  Game.randomize() {
    id = faker.guid.guid();
    players =
        List.generate(random.integer(8, min: 2), (n) => Player.randomize());
    completed = random.boolean();
    createdAt = DateTime.now().millisecondsSinceEpoch;
  }
}
