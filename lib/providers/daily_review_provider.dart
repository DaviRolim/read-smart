import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_smart/models/DailyReview.dart';
import 'package:read_smart/models/Failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/providers/highlights_provider.dart';
import 'package:read_smart/repository/highlights_repository.dart';
import 'package:read_smart/repository/sync_repository.dart';

import '../models/Book.dart';

enum NotifierState { initial, loading, loaded }

class DailyReviewProvider extends ChangeNotifier {
  final _highlightRepository = HighlightRepository();
  DailyReviewProvider(this.userID);

  final String userID;
  DailyReview? _dailyReview;
  DailyReview get dailyReview => _dailyReview ??  DailyReview.empty();
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void getDailyReview() async {
    _dailyReview = await _highlightRepository.getDailyReview(userID);
    notifyListeners();
  }

  void finishedDailyReview() async {
    print(dailyReview.finished);
    if (dailyReview.finished == null) {
      print('SalvandoReview');
      _highlightRepository.saveFinishedReview(userID);
      // Assuming everything works correctly (TODO add exception cases)
      _dailyReview?.setFinished(true);
      // notifyListeners();
    }
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  static final dailyReviewProvider =
      ChangeNotifierProvider<DailyReviewProvider>((ref) {
    final userID = ref.read(AuthProvider.authProvider).user!.uid;
    return DailyReviewProvider(userID);
  });
}
