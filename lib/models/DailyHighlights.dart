import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_smart/models/Highlight.dart';

class DailyHighlight {
  final List<HighlightExtended> highlights;

  DailyHighlight({
    required this.highlights,
  });


  factory DailyHighlight.fromJson(Map<String, dynamic>? data) {
    final allDailyHighlights = data!['quotes']
        .map((highlightExtended) => HighlightExtended.fromJson(highlightExtended))
        .toList()
        .cast<HighlightExtended>();

    return DailyHighlight(
      highlights: allDailyHighlights,
    );
  }

  toJson() {
    final highlightsMap = <Map<String, dynamic>>[];

  //   for (var highlight in highlights) {
  //     highlightsMap.add(highlight.toJson());
  //   }

    return {
      'highlight': '1',
    };
  }
}
