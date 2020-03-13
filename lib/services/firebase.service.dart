import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yaniv/models/game.model.dart';
import 'package:faker/faker.dart';

import '../models/player.model.dart';

class FirebaseService {
  static final FirebaseService _singleton = new FirebaseService._internal();
  final Firestore _db = Firestore.instance;
  String email;
  Faker faker = new Faker();

  factory FirebaseService() {
    return _singleton;
  }

  FirebaseService._internal();

  // @TODO improve this, maybe by using stream instead?
  setEmail(String email) {
    this.email = email;
  }

  Stream<Game> getGame(String id) {
    return _db
        .collection('games')
        .document(this.email)
        .collection('games')
        .document(id)
        .snapshots()
        .map((game) {
      List<dynamic> playersJson = game['players'];

      List<Player> players = playersJson.map((player) {
        return Player.fromJSON(new Map.from(player));
      }).toList();

      return new Game(
        completed: game['completed'],
        id: game.documentID,
        createdAt: game['createdAt'],
        players: players,
      );
    });
  }

  // @TODO do the map magic in here and return Stream<List<Game>>
  Stream<QuerySnapshot> getGames() {
    return _db
        .collection('games')
        .document(this.email)
        .collection('games')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<String> createNewGame() async {
    DocumentReference ref = await _db
        .collection('games')
        .document(this.email)
        .collection('games')
        .add({
      'completed': false,
      'createdAt': Timestamp.now(),
      'players': [],
      'name': faker.sport.name(),
    });

    return ref.documentID;
  }

  Future<void> deleteGame(String gameId) async {
    return _db
        .collection('games')
        .document(this.email)
        .collection('games')
        .document(gameId)
        .delete();
  }

  Future<String> addPlayerToGame(String gameId, String name) async {
    DocumentReference ref = _db
        .collection('games')
        .document(email)
        .collection('games')
        .document(gameId);

    List<dynamic> players = List.from((await ref.get()).data['players']);
    players.insert(players.length, {'name': name, 'points': 0});

    await ref.setData({
      'players': players,
    }, merge: true);

    return ref.documentID;
  }

  Future<void> removePlayerFromGame(String gameId, String name) async {
    DocumentReference ref = _db
        .collection('games')
        .document(email)
        .collection('games')
        .document(gameId);

    List<dynamic> players = List.from((await ref.get()).data['players']);
    players = players.where((player) => player['name'] != name).toList();

    await ref.setData({
      'players': players,
    }, merge: true);
  }

  Future<void> completeGame(String gameId) async {
    var ref = _db.collection('games').document(gameId);
    var game = (await ref.get()).data;
    game['completed'] = true;
    ref.setData({
      'game': game,
    }, merge: true);
  }

  int _calculatePoints(int oldPoints, int pointsToAdd) {
    int newPoints = oldPoints + pointsToAdd;
    if (newPoints == 100 || newPoints == 150) {
      return newPoints - 50;
    }
    if (newPoints == 200) {
      return 100;
    }
    return newPoints;
  }

  Future<void> addPointsToPlayer(String gameId, String name, int points) async {
    DocumentReference ref = _db
        .collection('games')
        .document(email)
        .collection('games')
        .document(gameId);

    List<dynamic> players = (await ref.get()).data['players'];

    players.forEach((player) {
      if (player['name'] == name) {
        int updatedPoints = _calculatePoints(player['points'], points);
        if (updatedPoints > 200) {
          completeGame(gameId);
        }
        player['points'] = updatedPoints;
      }
    });

    players.sort((a, b) => a['points'].compareTo(b['points']));

    await ref.setData({
      'players': players.toList(),
    }, merge: true);
  }
}
