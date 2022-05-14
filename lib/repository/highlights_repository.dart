import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_smart/models/DailyHighlights.dart';

import '../models/Book.dart';

class HighlightRepository {
  final userColl = FirebaseFirestore.instance.collection('users');

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
        .orderBy("lastAccessed", descending: true)
        .limit(4);
    return booksColl;
  }

  // I'll be using the lambda API to access this functionality
  Future<DailyHighlight> getDailyHighlights(String userID) async {
    var url = Uri.parse(
        'https://wyzvtfm3nrfmw3ycyobn5u6fum0wqyqk.lambda-url.us-east-1.on.aws' +
            '/?id=' +
            userID);
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    final body = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return DailyHighlight.fromJson(body);
  }
}
