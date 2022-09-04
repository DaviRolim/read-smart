import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:read_smart/models/Highlight.dart';

part 'Book.g.dart';

@HiveType(typeId: 2)
class Book {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String author;
  @HiveField(2)
  final String imageURL;
  @HiveField(3)
  final List<Highlight> highlights;

  Book({
    required this.title,
    required this.author,
    required this.imageURL,
    required this.highlights,
  });

  factory Book.fromJson(Map<String, dynamic>? data) {
    final highlights = data!['highlights']
        .map((highlightData) => Highlight.fromJson(highlightData))
        .toList()
        .cast<Highlight>();

    return Book(
      title: data['title'],
      highlights: highlights,
      author: data['author'],
      imageURL: data['imageURL'],
    );
  }

  toJson() {
    // TODO implement toJson return Map<String, dynamic>
    return {
      'highlight': '1',
    };
  }
}
