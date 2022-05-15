import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_smart/models/Highlight.dart';

class DailyReview {
  final List<HighlightExtended> highlights;
  bool? finished;

  DailyReview({
    required this.highlights,
    this.finished
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
      finished: data['finished'] ?? null
    );
  }

  toJson() {
    // TODO implement toJson return Map<String, dynamic>
    return {
      'highlight': '1',
    };
  }

  void setFinished(bool isFinished) {
    this.finished = isFinished;
  }
}
