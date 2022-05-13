import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Book.dart';

class HighlightRepository {
  final userColl = FirebaseFirestore.instance.collection('users');

  Query<Book> getUserBooks(String userID) {
    final Query<Book> booksColl =
        userColl.doc(userID).collection('books').withConverter<Book>(
            fromFirestore: (snapshot, _) {
              final bookJson  = snapshot.data();
              bookJson!['title'] = snapshot.id;
              return Book.fromJson(bookJson);
            },
            toFirestore: (Book book, _) => book.toJson()).orderBy("lastAccessed", descending: true).limit(4);
    return booksColl;
  }
}
