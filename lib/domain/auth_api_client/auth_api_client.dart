import 'dart:convert';
import 'dart:io';

import 'package:themoviedb/extension/extension_httpclient.dart';

enum ApiClientExceptionType { network, auth, other }

class ApiClientException implements Exception {
  final ApiClientExceptionType type;
  final String message;
  ApiClientException({required this.type, this.message = ''});
}

class AuthApiClient {
  final _client = HttpClient();
  static const _host = 'https://api.themoviedb.org/3';
  static const _apiKey = '8060ec90419b19242da45c067a70a67e';

  Future<String> auth({required String login, required String password}) async {
    final validToken = await _validateUser(login: login, password: password);
    final sessionId = await _makeSession(token: validToken);
    return sessionId;
  }

  Future<String> _makeToken() async {
    final response = await _client.myGet(
        host: _host,
        path: '/authentication/token/new',
        parameters: {'api_key': _apiKey}); //await request.close();
    final json = await _client.myJsonDecode(response) as Map<String, dynamic>;
    final token = json['request_token'];
    return token;
  }

  Future<String> _validateUser(
      {required String login, required String password}) async {
    final oldToken = await _makeToken();
    final url = _client.makeUri(
        host: _host,
        path: '/authentication/token/validate_with_login',
        parameters: {'api_key': _apiKey});
    final param = <String, dynamic>{
      "username": login,
      "password": password,
      "request_token": oldToken
    };
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(param));
    final response = await request.close();
    final json =
        await await _client.myJsonDecode(response) as Map<String, dynamic>;
    if (json['status_message'] != null) {
      throw ApiClientException(
          type: ApiClientExceptionType.network,
          message: json['status_message']);
    }
    final token = json['request_token'];
    return token;
  }

  Future<String> _makeSession({required String token}) async {
    final url = _client.makeUri(
        host: _host,
        path: '/authentication/session/new',
        parameters: {'api_key': _apiKey});

    final param = <String, dynamic>{"request_token": token};
    final request = await _client.postUrl(url);
    request.headers.contentType = ContentType.json;
    request.write(jsonEncode(param));
    final response = await request.close();
    final json = await _client.myJsonDecode(response) as Map<String, dynamic>;
    final sessionId = json['session_id'];
    return sessionId;
  }

//MARK: helper methods
//   dynamic _jsonDecode(HttpClientResponse response) async {
//     final json = await response
//         .transform(utf8.decoder)
//         .toList()
//         .then((value) => value.join())
//         .then((value) => jsonDecode(value));
//     return json;
//   }
//
//   Uri _makeUri(String path, [Map<String, dynamic>? parameters]) {
//     final uri = Uri.parse('$_host$path');
//     if (parameters != null) {
//       return uri.replace(queryParameters: parameters);
//     }
//     return uri;
//   }
}
