import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:read_smart/models/DailyReview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_smart/providers/auth_provider.dart';
import 'package:read_smart/providers/notifier_enum.dart';
import 'package:read_smart/repository/book_repository.dart';

import '../repository/user_streak_repository.dart';

class DailyReviewProvider extends ChangeNotifier {
  final _bookRepository = BookRepository();
  final _userStreakRepository = UserStreakRepository();
  DailyReviewProvider(this.userID);

  final String userID;
  DailyReview? _dailyReview;
  DailyReview get dailyReview => _dailyReview ?? DailyReview.empty();
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  int? _currentStreak;
  int? get currentStreak => _currentStreak;
  String? get progressText {
    if (_dailyReview != null) {
      int highlightsLenght = dailyReview.highlights.length;
      final alreadySeenText = _currentIndex.toString() +
          "/" +
          highlightsLenght.toString() +
          ' to complete your review today.';
      return _dailyReview!.finished
          ? "You've completed today's review."
          : alreadySeenText;
    }
    return null;
  }

  Future<void> getDailyReview() async {
    _dailyReview = await _bookRepository.getDailyReview(userID);
    notifyListeners();
  }

  void fetchUserStreak() async {
    final streak = _userStreakRepository.getUserStreakLocal();
    _currentStreak = streak;
    notifyListeners();
  }

  void finishedDailyReview() async {
    if (!dailyReview.finished) {
      print('SalvandoReview');
      final streak = await _userStreakRepository.increaseUserStreak(userID);
      _currentStreak = streak;
      // Assuming everything works correctly (TODO add exception cases)
      _dailyReview?.setFinished(true);
      notifyListeners();
    }
  }

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    if (index == dailyReview.highlights.length - 1) {
      finishedDailyReview();
    }
    notifyListeners();
  }

  static final dailyReviewProvider =
      ChangeNotifierProvider<DailyReviewProvider>((ref) {
    final userID = ref.read(AuthProvider.authProvider).user!.uid;
    return DailyReviewProvider(userID);
  });
}
