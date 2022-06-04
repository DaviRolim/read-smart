import 'dart:convert';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  static final authInstance = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    var userAuthenticated = false;
    print(email + ' - ' + password);
    try {
      UserCredential userCredential =
          await authInstance.signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      userAuthenticated = true;
      saveAuthInfoLocalStorage(email, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('User not found!');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password');
      } else {
        throw Exception('Try again later');
      }
    }
    return userAuthenticated;
  }

  Future<bool> signOut() async {
    bool userAuthenticated = true;
    try {
      await authInstance.signOut();
      userAuthenticated = false;
      final prefs = await SharedPreferences.getInstance();
      // prefs.remove('authInfo');
      prefs.clear();
    } catch (e) {
      throw Exception('Error signing Out');
    }
    return userAuthenticated;
  }

  Future<bool> signUpWithEmailAndPassword(
    String email,
    String password,
    String username,
  ) async {
    var userAuthenticated = false;
    try {
      UserCredential userCredential =
          await authInstance.createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({'username': username, 'email': email});
      userAuthenticated = true;
      saveAuthInfoLocalStorage(email, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('weak password');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('Email already in use');
      }
    } catch (e) {
      throw Exception('A problem occurred try again later');
    }
    return userAuthenticated;
  }

  void saveAuthInfoLocalStorage(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final authInfo = json.encode({
        'email': email,
        'password': password,
      });
      prefs.setString('authInfo', authInfo);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return false;
      }

      final googleAuthentication = await googleUser.authentication;

      final authCredential = GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );
      print(authCredential);

      await authInstance.signInWithCredential(authCredential);
      return true;
    } on FirebaseAuthException catch (_) {
      return false;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('authInfo')) {
      return false;
    }
    final extractedAuthInfo =
        Map<String, dynamic>.from(json.decode(prefs.getString('authInfo')!));

    signInWithEmailAndPassword(extractedAuthInfo['email'] as String,
        extractedAuthInfo['password'] as String);
    return true;
  }

  User? getLoggedUser() {
    return authInstance.currentUser;
  }
}
