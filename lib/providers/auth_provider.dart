import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_smart/models/Failure.dart';
import 'package:read_smart/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/Failure.dart';
import 'notifier_enum.dart';

class AuthProvider extends ChangeNotifier {
  final _authRepository = AuthRepository();

  User? _user;
  User? get user => _user;

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  AuthProvider() {
    AuthRepository.authInstance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void signOut() async {
    try {
      _authRepository.signOut();
      notifyListeners();
    } on Failure catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Unit> signInWithEmailAndPassword(String email, String password) async {
    _setState(NotifierState.loading);
    print(email + password);
    try {
      await _authRepository.signInWithEmailAndPassword(
        email,
        password,
      );
    } on Failure catch (e) {
      print(e.toString());
      throw e;
    }

    _setState(NotifierState.loaded);
    return unit;
  }

  Future<Unit> signInWithGoogle() async {
    _setState(NotifierState.loading);
    try {
      await _authRepository.signInWithGoogle();
    } on Failure catch (e) {
      print(e.toString());
      throw e;
    }
    _setState(NotifierState.loaded);
    return unit;
  }

  Future<Unit> signUpWithEmailAndPassword(
      String email, String password, String username) async {
    _setState(NotifierState.loading);
    try {
      await _authRepository.signUpWithEmailAndPassword(
          email, password, username);
    } on Failure catch (e) {
      throw e;
    }

    _setState(NotifierState.loaded);
    return unit;
  }

  void tryAutoLogin() {
    _authRepository.tryAutoLogin();
  }

  static final authProvider =
      ChangeNotifierProvider<AuthProvider>((ref) => AuthProvider());
}
