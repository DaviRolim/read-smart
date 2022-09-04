import 'package:dartz/dartz.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import '../../core/error/exceptions.dart';

class UserInfoRemoteDataSource {
  final http.Client client;
  UserInfoRemoteDataSource(this.client);
  Future<int> increaseUserStreakRemote(String userID) async {
    var url = Uri.parse(
        'https://p3guee5qz2p3hakt2laeyok7xe0swehi.lambda-url.us-east-1.on.aws' +
            '/?id=' +
            userID);
    var response = await client.post(
      url,
      headers: {"Content-Type": "application/json"},
    );
    final resMap = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return resMap['streak'];
  }

  Future<int> getUserStreak(String userID) async {
    try {
      var url = Uri.parse(
          'https://p3guee5qz2p3hakt2laeyok7xe0swehi.lambda-url.us-east-1.on.aws' +
              '/?id=' +
              userID);
      var response = await client.get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode != 200) {
        throw ServerException();
      }
      final resMap = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return resMap['streak'];
    } catch (e) {
      throw ServerException();
    }
  }
}
