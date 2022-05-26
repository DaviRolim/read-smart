import 'package:cloud_firestore/cloud_firestore.dart';

class SyncStatus {
  final Timestamp startTime;
  final int totalBooks;
  final int updatedBooks;
  int highlightsAdded;
  Timestamp? endTime;

  SyncStatus(
      {required this.startTime,
      required this.updatedBooks,
      required this.totalBooks,
      required this.highlightsAdded,
      this.endTime});

  factory SyncStatus.fromJson(Map<String, dynamic>? data) {
    return SyncStatus(
      startTime: data?['startTime'],
      totalBooks: data?['totalBooks'],
      updatedBooks: data?['updatedBooks'],
      highlightsAdded: data?['highlightsAdded'],
      endTime: data?['endTime'] ?? null,
    );
  }

  toJson() {
    // TODO implement toJson return Map<String, dynamic>
    return {
      'highlight': '1',
    };
  }
}
