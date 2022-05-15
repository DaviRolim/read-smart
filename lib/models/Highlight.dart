import 'package:cloud_firestore/cloud_firestore.dart';

class HighlightExtended {
  final String title;
  final String author;
  final String imageURL;
  final Highlight highlight;

  HighlightExtended({
    required this.title,
    required this.author,
    required this.imageURL,
    required this.highlight,
  });

  factory HighlightExtended.fromJson(Map<String, dynamic>? data) {
    final highlight = Highlight.fromJson(data!['highlight']);

    return HighlightExtended(
      title: data['title'],
      highlight: highlight,
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

class Highlight {
  final String text;
  final bool isFavorite;

  Highlight({required this.text, required this.isFavorite});
  factory Highlight.fromJson(Map<String, dynamic> data) {
    return Highlight(
      text: data['highlight'],
      isFavorite: data['isFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'highlight': text,
      'isFavorite': isFavorite,
    };
  }
}
