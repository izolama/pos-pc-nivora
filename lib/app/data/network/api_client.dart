import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import '../exceptions/app_exception.dart';
import 'auth_token_store.dart';

class ApiClient {
  ApiClient({
    required this.baseUrl,
    required this.tokenStore,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final AuthTokenStore tokenStore;
  final http.Client _httpClient;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) {
    return _send(
      method: 'GET',
      path: path,
      queryParameters: queryParameters,
      requiresAuth: requiresAuth,
    );
  }

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) {
    return _send(
      method: 'POST',
      path: path,
      body: body,
      queryParameters: queryParameters,
      requiresAuth: requiresAuth,
    );
  }

  Future<Map<String, dynamic>> put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) {
    return _send(
      method: 'PUT',
      path: path,
      body: body,
      queryParameters: queryParameters,
      requiresAuth: requiresAuth,
    );
  }

  Future<Map<String, dynamic>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool requiresAuth = true,
  }) {
    return _send(
      method: 'DELETE',
      path: path,
      queryParameters: queryParameters,
      requiresAuth: requiresAuth,
    );
  }

  Future<Map<String, dynamic>> postMultipart({
    required String path,
    required String fileField,
    required Uint8List bytes,
    required String filename,
    String? baseUrlOverride,
    bool requiresAuth = true,
  }) async {
    final uri = Uri.parse('${baseUrlOverride ?? baseUrl}$path');
    final request = http.MultipartRequest('POST', uri);
    request.headers['Accept'] = 'application/json';

    if (requiresAuth) {
      final token = tokenStore.token;
      if (token == null || token.isEmpty) {
        throw AppException('Bearer token is missing.');
      }
      request.headers['Authorization'] = 'Bearer $token';
    }

    request.files.add(
      http.MultipartFile.fromBytes(fileField, bytes, filename: filename),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    final decodedBody = _decodeJson(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = decodedBody['message']?.toString() ?? 'Request failed.';
      throw AppException(message, statusCode: response.statusCode);
    }

    return decodedBody;
  }

  Future<Map<String, dynamic>> _send({
    required String method,
    required String path,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
    required bool requiresAuth,
  }) async {
    final uri = Uri.parse('$baseUrl$path').replace(
      queryParameters: queryParameters?.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
    );

    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (requiresAuth) {
      final token = tokenStore.token;
      if (token == null || token.isEmpty) {
        throw AppException('Bearer token is missing.');
      }
      headers['Authorization'] = 'Bearer $token';
    }

    late final http.Response response;

    switch (method) {
      case 'GET':
        response = await _httpClient.get(uri, headers: headers);
      case 'POST':
        response = await _httpClient.post(
          uri,
          headers: headers,
          body: body == null ? null : jsonEncode(body),
        );
      case 'PUT':
        response = await _httpClient.put(
          uri,
          headers: headers,
          body: body == null ? null : jsonEncode(body),
        );
      case 'DELETE':
        response = await _httpClient.delete(uri, headers: headers);
      default:
        throw AppException('Unsupported HTTP method: $method');
    }

    final decodedBody = _decodeJson(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = decodedBody['message']?.toString() ?? 'Request failed.';
      throw AppException(message, statusCode: response.statusCode);
    }

    return decodedBody;
  }

  Map<String, dynamic> _decodeJson(String body) {
    if (body.isEmpty) {
      return const <String, dynamic>{};
    }

    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    throw AppException('Unexpected response format.');
  }
}
