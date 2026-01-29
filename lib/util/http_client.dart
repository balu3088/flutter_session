import 'dart:convert';

import 'package:batch_four_exp/common/services/shared_pref_config.dart';
import 'package:batch_four_exp/config/app_config.dart';
import 'package:http/http.dart' as http;

class HttpClientWrapper {
  final String? baseUrl;

  const HttpClientWrapper({this.baseUrl});

  Uri _buildUri(String path, {Map<String, String>? queryParameters}) {
    // Use provided baseUrl, otherwise use default from AppConfig
    final baseUri = Uri.parse(baseUrl ?? AppConfig.baseUrl);
    final resolvedUri = baseUri.resolve(path);
    if (queryParameters == null || queryParameters.isEmpty) {
      return resolvedUri;
    }
    return resolvedUri.replace(queryParameters: queryParameters);
  }

  Future<Map<String, String>> _buildHeaders() async {
    final mergedHeaders = <String, String>{};

    // Get auth token from SharedPreferences
    String? token;
    try {
      final prefs = await SharedPrefConfig.getInstance();
      token = prefs.getString('authToken');
    } catch (e) {
      print('Error getting auth token from SharedPreferences: $e');
    }

    // Add Bearer token if available
    mergedHeaders['Content-Type'] = 'application/json';
    if (token != null && token.isNotEmpty) {
      mergedHeaders['Authorization'] = 'Bearer $token';
    }

    return mergedHeaders;
  }

  Future<http.Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final uri = _buildUri(path, queryParameters: queryParameters);
    final mergedHeaders = await _buildHeaders();
    return http.get(uri, headers: mergedHeaders);
  }

  Future<http.Response> post(
    String path, {
    Map<String, String>? queryParameters,
    Object? body,
  }) async {
    final uri = _buildUri(path, queryParameters: queryParameters);
    final mergedHeaders = await _buildHeaders();
    return http.post(
      uri,
      headers: mergedHeaders,
      body: body,
    );
  }
}
