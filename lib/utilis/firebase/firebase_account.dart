
 import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAccount{


  Future<UserCredential> logIn(String email, String pass) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.signInWithEmailAndPassword(email: email, password: pass);
  }
  Future<void> logOut( ) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.signOut()

    ;
  }
  Future<UserCredential> createNewAccount(String email, String pass) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.createUserWithEmailAndPassword(email: email, password: pass);
  }

}