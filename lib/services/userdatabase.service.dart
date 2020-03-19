import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabaseService {

    final String uid;
    final String email;
    UserDatabaseService({ this.uid, this.email });

    final CollectionReference userReference = Firestore.instance.collection('games');

    Future updateUserData(String name) async {

      return await userReference.document(email).setData({

          'name': name,
          'email': email,

      });

    }

    Stream<QuerySnapshot> get userReferenceData {
      return userReference.snapshots();
    }

}