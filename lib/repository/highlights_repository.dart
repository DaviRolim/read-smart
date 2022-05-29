import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:read_smart/models/DailyReview.dart';

import '../models/Book.dart';

class HighlightRepository {
  final userColl = FirebaseFirestore.instance.collection('users');

  // TODO create an interface IBookRepository
  // Create a class to extend this interface BookRepository
  // this BookRepository will make use of -> BookRemoteRepository and BookLocalRepository
  // Start with test, LETS DO THIS.
  Query<Book> getUserBooks(String userID) {
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
        .orderBy("lastAccessed",
            descending:
                true); // TODO - Warning. Without limit this will be expensive to run this many times for each user. Later I should save everything local and only update when the user sync.
    return booksColl;
  }

  // I'll be using the lambda API to access this functionality
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
}
