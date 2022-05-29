import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_smart/models/Failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/repository/highlights_repository.dart';
import 'dart:async';

import '../models/Book.dart';
import '../models/Failure.dart';
import 'notifier_enum.dart';

// TODO change name to BooksProvider
class HighlightsProvider extends ChangeNotifier {
  final _highlightRepository = HighlightRepository();
  List<Book>? _highlights;
  List<Book>? _filteredHighlights;
  List<Book> get highlights => _highlights ?? [];
  List<Book> get filteredHighlights => _filteredHighlights ?? [];
  Timer? _debounce;
  bool? _isLoading;
  bool get isLoading => _isLoading ?? false;

  final String userID;
  HighlightsProvider(this.userID);

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void resetFilter() {
    _filteredHighlights = _highlights;
    notifyListeners();
  }

  void sortBooks() {
    _filteredHighlights!.sort((a, b) => a.title.compareTo(b.title));
    notifyListeners();
  }

  void filterBooks(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (query.isEmpty) {
        _filteredHighlights = _highlights;
      } else {
        _filteredHighlights = _highlights!
            .where((book) =>
                book.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      notifyListeners();
    });
  }

  void fetchHighlights() {
    Query<Book> booksRef = _highlightRepository.getUserBooks(userID);
    booksRef.snapshots().listen((event) {
      _highlights = event.docs.map((e) => e.data()).toList();
      _filteredHighlights = _highlights;
      notifyListeners();
    });
  }

  static final highlightsProvider =
      ChangeNotifierProvider<HighlightsProvider>((ref) {
    final userID = ref.read(AuthProvider.authProvider).user!.uid;
    return HighlightsProvider(userID);
  });
}
