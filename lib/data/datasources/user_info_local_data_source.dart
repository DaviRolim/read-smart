import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../core/error/exceptions.dart';

class UserInfoLocalDataSource {
  final HiveInterface hive;

  UserInfoLocalDataSource(this.hive);

  Future<int> getStreak() async {
    try {
      var userInfoBox = await hive.openBox('userInfo');
      final streak = userInfoBox.get('userStreak');
      if (streak != null) {
        return streak;
      }
      return 0;
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> cacheUserStreak(int streak) async {
    try {
      var userInfoBox = await hive.openBox('userInfo');
      userInfoBox.put('userStreak', streak);
    } catch (e) {
      throw CacheException();
    }
  }
}
