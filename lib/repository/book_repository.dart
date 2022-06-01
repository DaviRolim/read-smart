import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:read_smart/models/DailyReview.dart';

import '../models/Book.dart';

class BookRepository {
  final userColl = FirebaseFirestore.instance.collection('users');

  Query<Book> _getBooksRemote(String userID) {
    final Query<Book> booksColl = userColl
        .doc(userID)
        .collection('books')
        .withConverter<Book>(
            fromFirestore: (snapshot, _) {
              final bookJson = snapshot.data();
              bookJson!['title'] = snapshot.id;
              return Book.fromJson(bookJson);
            },
            toFirestore: (Book book, _) => book.toJson())
        .orderBy("lastAccessed", descending: true);
    return booksColl;
  }

  Future<DailyReview> getDailyReview(String userID) async {
    var url = Uri.parse(
        'https://wyzvtfm3nrfmw3ycyobn5u6fum0wqyqk.lambda-url.us-east-1.on.aws' +
            '/?id=' +
            userID);
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json", "charset": "utf-8"},
    );
    final body =
        json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    return DailyReview.fromJson(body);
  }

  Future<void> _syncBooks(String username, email, password) async {
    var url = Uri.parse(
        'https://ij63trl27tlpgkvas2bc2twvvm0suzgk.lambda-url.us-east-1.on.aws');
    await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
            {'username': username, 'email': email, 'password': password}));
  }

  Future<void> updateBooks(String username, email, password) async {
    await _syncBooks(username, email, password);
    final booksRef = _getBooksRemote(username);
    booksRef.snapshots().listen((event) {
      final _books = event.docs.map((e) => e.data()).toList();
      if (_books.isNotEmpty) {
        var bookBox = Hive.box<Book>('books');
        print('chegou aqui');
        print(bookBox.values.length);
        bookBox.clear();
        print(bookBox.values.length);
        bookBox.addAll(_books);
        print(bookBox.values.length);
      }
    });
  }
}
