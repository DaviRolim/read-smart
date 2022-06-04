import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/repository/book_repository.dart';
import 'dart:async';

import '../models/Book.dart';
import 'notifier_enum.dart';

// TODO change name to BooksProvider
class BooksProvider extends ChangeNotifier {
  final _bookRepository = BookRepository();
  List<Book>? _books;
  List<Book>? _filteredBooks;
  List<Book> get highlights => _books ?? [];
  List<Book> get filteredBooks => _filteredBooks ?? [];
  Timer? _debounce;
  bool? _isLoading;
  bool get isLoading => _isLoading ?? false;

  final String userID;
  BooksProvider(this.userID);

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void resetFilter() {
    _filteredBooks = _books;
    notifyListeners();
  }

  void sortBooks() {
    _filteredBooks!.sort((a, b) => a.title.compareTo(b.title));
    notifyListeners();
  }

  void filterBooks(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (query.isEmpty) {
        _filteredBooks = _books;
      } else {
        _filteredBooks = _books!
            .where((book) =>
                book.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
      notifyListeners();
    });
  }

  void loadBooks() async {
    var bookBox = Hive.box<Book>('books');
    print(bookBox.values.length);
    if (bookBox.values.length > 0) {
      print('Getting values from the box');
      _books = bookBox.values.toList();
      _filteredBooks = _books;
    } else {
      // TODO
      print('no books in local database, sync first');
    }
    notifyListeners();
  }

  static final booksProvider = ChangeNotifierProvider<BooksProvider>((ref) {
    final userID = ref.read(AuthProvider.authProvider).user!.uid;
    return BooksProvider(userID);
  });
}
