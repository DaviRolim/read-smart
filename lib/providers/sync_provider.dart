import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/repository/book_repository.dart';

import '../models/SyncStatus.dart';

enum NotifierState { initial, loading, loaded }

class SyncProvider extends ChangeNotifier {
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs;
  bool isSync = false;
  int booksUpdated = 0;
  SyncProvider(this.userID) {
    Query<SyncStatus> syncRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('sync')
        .withConverter<SyncStatus>(
            fromFirestore: (snapshot, _) {
              return SyncStatus.fromJson(snapshot.data());
            },
            toFirestore: (SyncStatus syncProvider, _) => syncProvider.toJson())
        .orderBy("startTime", descending: true)
        .limit(1);

    syncRef.snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        // is a list with one element because I'm using limit 1
        final syncDoc = event.docs[0];
        final syncStatus = syncDoc.data();
        booksUpdated = syncStatus.updatedBooks;
        notifyListeners();
      }
    });
  }
  final String userID;
  final _bookRepository = BookRepository();
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void syncBooks(email, password) async {
    _setState(NotifierState.loading);
    await _bookRepository.updateBooks(userID, email, password);
    Future.delayed(Duration(seconds: 2), () {
      _setState(NotifierState.loaded);
    });
    // TODO Handle errors (if statusCode != 200?)
  }

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  static final syncProvider = ChangeNotifierProvider<SyncProvider>((ref) {
    final userID = ref.read(AuthProvider.authProvider).user!.uid;
    return SyncProvider(userID);
  });
}
