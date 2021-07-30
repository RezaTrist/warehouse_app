import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> loginWithEmailAndPassword(
      {String? email, String? password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return 'Welcome';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    throw Exception('Something Wrong!');
  }

  Future<String> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    throw Exception('Something Wrong!');
  }

  void logOut() async {
    firebaseAuth.signOut();
  }

  Future<bool> isSignedIn() async {
    final currentUser = firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String?> getUser() async {
    return (firebaseAuth.currentUser!).email;
  }
}
