import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_smart/models/Failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/repository/highlights_repository.dart';

import '../models/Book.dart';
import '../models/Failure.dart';

class HighlightsProvider extends ChangeNotifier {
  final _highlightRepository = HighlightRepository();
  List<QueryDocumentSnapshot<Book>>? _highlights;
  List<QueryDocumentSnapshot<Book>> get highlights => _highlights ?? [];
  
  final String userID;
  HighlightsProvider(this.userID);

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;

  void fetchHighlghts() {
    Query<Book> booksRef = _highlightRepository.getUserBooks(userID);
    booksRef.snapshots().listen((event) {
      _highlights = event.docs;
      notifyListeners();
    });
  }

  static final highlightsProvider =
      ChangeNotifierProvider<HighlightsProvider>((ref) {
        final userID = ref.read(AuthProvider.authProvider).user!.uid;
        return HighlightsProvider(userID);
      });
}
