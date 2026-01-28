import 'dart:convert';

import 'package:batch_four_exp/config/app_config.dart';
import 'package:http/http.dart' as http;

class HttpClientWrapper {
  const HttpClientWrapper();

  Uri _buildUri(String path, {Map<String, String>? queryParameters}) {
    final baseUri = Uri.parse(AppConfig.baseUrl);
    final resolvedUri = baseUri.resolve(path);
    if (queryParameters == null || queryParameters.isEmpty) {
      return resolvedUri;
    }
    return resolvedUri.replace(queryParameters: queryParameters);
  }

  Map<String, String> _buildHeaders(
    Map<String, String>? headers, {
    String? authorizationToken,
  }) {
    final mergedHeaders = <String, String>{};
    if (headers != null) {
      mergedHeaders.addAll(headers);
    }
    if (authorizationToken != null && authorizationToken.isNotEmpty) {
      mergedHeaders['Authorization'] = authorizationToken;
    }
    return mergedHeaders;
  }

  Future<http.Response> get(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? authorizationToken,
  }) {
    final uri = _buildUri(path, queryParameters: queryParameters);
    final mergedHeaders = _buildHeaders(
      headers,
      authorizationToken: authorizationToken,
    );
    return http.get(uri, headers: mergedHeaders);
  }

  Future<http.Response> post(
    String path, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Object? body,
    Encoding? encoding,
    String? authorizationToken,
  }) {
    final uri = _buildUri(path, queryParameters: queryParameters);
    final mergedHeaders = _buildHeaders(
      headers,
      authorizationToken: authorizationToken,
    );
    return http.post(
      uri,
      headers: mergedHeaders,
      body: body,
      encoding: encoding,
    );
  }
}
