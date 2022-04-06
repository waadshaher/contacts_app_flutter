import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vimigo_technical_assessment/model/user.dart';

class DataService {
  static const String baseUrl = 'http://10.0.2.2:3333';

  Future get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future patch(String endpoint, {dynamic data}) async {
    final response = await http.patch(Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future<User> getUser(int id) async {
    final json = await get('data/$id');
    return User.fromJson(json);
  }

  Future<List<User>> getUsers() async {
    final json = await get('data/');
    List<User> users = [];
    for (var item in json) {
      users.add(User.fromJson(item));
    }
    return users;
  }
}

final dataService = DataService();
