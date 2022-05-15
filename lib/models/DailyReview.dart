import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_smart/models/Highlight.dart';

class DailyReview {
  final List<HighlightExtended> highlights;

  DailyReview({
    required this.highlights,
  });

  factory DailyReview.empty() {
    return DailyReview(highlights: []);
  }

  factory DailyReview.fromJson(Map<String, dynamic>? data) {
    final allDailyReview = data!['quotes']
        .map((highlightExtended) =>
            HighlightExtended.fromJson(highlightExtended))
        .toList()
        .cast<HighlightExtended>();

    return DailyReview(
      highlights: allDailyReview,
    );
  }

  toJson() {
    // TODO implement toJson return Map<String, dynamic>
    return {
      'highlight': '1',
    };
  }
}
