import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class DailyReviewRepository {
  Future<Map<String, dynamic>> increaseUserStreak(String userID) async {
    var url = Uri.parse(
        'https://p3guee5qz2p3hakt2laeyok7xe0swehi.lambda-url.us-east-1.on.aws' +
            '/?id=' +
            userID);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );
    return convert.jsonDecode(response.body) as Map<String, dynamic>;
  }
  Future<Map<String, dynamic>> getUserStreak(String userID) async {
    var url = Uri.parse(
        'https://p3guee5qz2p3hakt2laeyok7xe0swehi.lambda-url.us-east-1.on.aws' +
            '/?id=' +
            userID);
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    return convert.jsonDecode(response.body) as Map<String, dynamic>;
  }
}
