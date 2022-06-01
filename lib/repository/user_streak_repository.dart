import 'dart:convert' as convert;

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class UserStreakRepository {
  Future<int> increaseUserStreak(userID) async {
    final streak = await increaseUserStreakLocal();
    try {
      await increaseUserStreakRemote(userID);
    } catch (e) {
      print(e.toString());
    }
    return streak;
  }

  Future<int> increaseUserStreakRemote(String userID) async {
    var url = Uri.parse(
        'https://p3guee5qz2p3hakt2laeyok7xe0swehi.lambda-url.us-east-1.on.aws' +
            '/?id=' +
            userID);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );
    final resMap = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return resMap['streak'];
  }

  Future<int> increaseUserStreakLocal() async {
    var userInfoBox = Hive.box('userInfo');
    final currentStreak = userInfoBox.get('userStreak', defaultValue: 0);
    userInfoBox.put('userStreak', currentStreak + 1);
    return Future.value(currentStreak + 1);
  }

  int getUserStreakLocal() {
    var userInfoBox = Hive.box('userInfo');
    final currentStreak = userInfoBox.get('userStreak', defaultValue: 0);
    return currentStreak;
  }

  Future<int> getUserStreak(String userID) async {
    var url = Uri.parse(
        'https://p3guee5qz2p3hakt2laeyok7xe0swehi.lambda-url.us-east-1.on.aws' +
            '/?id=' +
            userID);
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    final resMap = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return resMap['streak'];
  }
}
