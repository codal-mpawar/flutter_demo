import 'dart:convert';
import 'package:demo/services/urls.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<dynamic> userLoginAPI(params) async {
    try {
      final uri = Uri.parse(baseUrl + apiUrl['LOGIN']!);
      final response = await http.post(uri, body: params);
      return response;
    } catch (error) {
      Future.error(error);
    }
  }

  Future<List> fetchUserAPI(page) async {
    final uri = Uri.parse('${baseUrl + apiUrl['USERS']!}?page=$page&limit=15');
    final response = await http.get(uri);
    final body = response.body;
    final jsonResponse = jsonDecode(body);
    final usersData = jsonResponse['data'] as List<dynamic>;
    return usersData;
  }

  Future<dynamic> deleteUserAPI(userId) async {
    try {
      final uri = Uri.parse('${baseUrl + apiUrl['USERS']!}/$userId');
      final response = await http.delete(uri);
      return response;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> createUserAPI(params) async {
    try {
      final uri = Uri.parse(baseUrl + apiUrl['USERS']!);
      final response = await http.post(uri, body: params.toString());
      return response;
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<dynamic> updateUserAPI(userId, params) async {
    try {
      final uri = Uri.parse('${baseUrl + apiUrl['USERS']!}/$userId');
      final response = await http.patch(uri, body: params.toString());
      return response;
    } catch (error) {
      return Future.error(error);
    }
  }
}
