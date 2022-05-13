import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class SyncRepository {
  Future<Map<String, dynamic>> syncHighlights(
      String username, email, password) async {
    var url = Uri.parse(
        'https://ij63trl27tlpgkvas2bc2twvvm0suzgk.lambda-url.us-east-1.on.aws');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: convert.jsonEncode(
            {'username': username, 'email': email, 'password': password}));
    return convert.jsonDecode(response.body) as Map<String, dynamic>;
  }
}
