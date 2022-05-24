import 'package:cloud_firestore/cloud_firestore.dart';

class SyncStatus {
  final Timestamp startTime;
  final int totalBooks;
  final int updatedBooks;
  Timestamp? endTime;

  SyncStatus(
      {required this.startTime,
      required this.updatedBooks,
      required this.totalBooks,
      this.endTime});

  factory SyncStatus.fromJson(Map<String, dynamic>? data) {
    return SyncStatus(
      startTime: data?['startTime'],
      totalBooks: data?['totalBooks'],
      updatedBooks: data?['updatedBooks'],
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
