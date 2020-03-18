import 'package:firebase_auth/firebase_auth.dart';

// custom user model
class User {
    final String email;
    User({this.email});
  }

class AuthService {

    final FirebaseAuth _yauth = FirebaseAuth.instance;

    // user obj based on FirebaseUser

    User _userFromFirebaseUser(FirebaseUser user) {
      return user != null ? User(email: user.email) : null;
    }

    // auth change user stream

    Stream<User> get user {
      return _yauth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
    }

    //sign in with email & pass
    Future signInEmailPass(String email, String password) async {
      try {
        AuthResult result = await _yauth.signInWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
        
      } catch(e) {
        print(
          e.toString()
        );
        return null;
      }
    }

    //register email & pass
    Future registerEmailPass(String email, String password) async {
      try {
        AuthResult result = await _yauth.createUserWithEmailAndPassword(email: email, password: password);
        FirebaseUser user = result.user;
        return _userFromFirebaseUser(user);
        
      } catch(e) {
        print(
          e.toString()
        );
        return null;
      }
    }

    //signout

    Future signOut() async {
      try {
        return await _yauth.signOut();
      } catch(e) {
        print(
          e.toString()
        );
        return null;
      }
    }

}