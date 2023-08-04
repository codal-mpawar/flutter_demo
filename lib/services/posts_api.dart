import 'dart:convert';
import 'package:demo/services/urls.dart';
import 'package:http/http.dart' as http;

class PostsAPI {
  Future<List> fetchPosts(page) async {
    final uri =
        Uri.parse('${postBaseUrl + apiUrl['POSTS']!}?offset=$page&limit=10');
    final response = await http.get(uri);
    final body = response.body;
    final jsonResponse = jsonDecode(body);
    final postsData = jsonResponse['photos'] as List<dynamic>;
    return postsData;
  }
}
