import 'dart:convert';

import 'package:batch_four_exp/util/http_client.dart';

class TodoData {
  TodoData({HttpClientWrapper? httpClient})
      : _httpClient = httpClient ?? const HttpClientWrapper();

  final HttpClientWrapper _httpClient;

  Future<List<String>> addTodo(String todoData, List<String> todoList) async {
    await Future.delayed(Duration(seconds: 2));
    return [...todoList, todoData];
  }

  Future<List<String>> getTodoFromServer() async {
    final response = await _httpClient.get('/todos');
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => item['title'] as String).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
// Sample post method
  /*Future<Map<String, dynamic>> createTodo(Map<String, dynamic> body,
      {String? authorizationToken}) async {
    final response = await _httpClient.post(
      '/todos',
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(body),
      authorizationToken: authorizationToken,
    );
    if (response.statusCode == 201) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to create todo');
    }
  }*/
}
