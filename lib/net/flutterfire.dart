// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('Password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('Account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}
