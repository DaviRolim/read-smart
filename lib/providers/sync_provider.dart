import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_smart/models/Failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/repository/highlights_repository.dart';
import 'package:read_smart/repository/sync_repository.dart';

import '../models/Book.dart';

enum NotifierState { initial, loading, loaded }

class SyncProvider extends ChangeNotifier {

  SyncProvider(this.userID);

  final String userID;
  final _syncRepository = SyncRepository();
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void syncHighlights(email, password) async {
    print('syncHighlights -> $userID - $email - $password');
    _setState(NotifierState.loading);
    await _syncRepository.syncHighlights(userID, email, password);
    _setState(NotifierState.loaded);
    // TODO Handle errors (if statusCode != 200?)

  }

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }
static final syncProvider =
      ChangeNotifierProvider<SyncProvider>((ref) {
        final userID = ref.read(AuthProvider.authProvider).user!.uid;
        return SyncProvider(userID);
      });

}

