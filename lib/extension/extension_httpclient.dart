import 'dart:convert';
import 'dart:io';

extension MyHelpers on HttpClient {
  Uri makeUri(
      {required String host,
      required String path,
      required Map<String, dynamic>? parameters}) {
    final uri = Uri.parse('$host$path');
    if (parameters != null) {
      return uri.replace(queryParameters: parameters);
    }
    return uri;
  }

  dynamic myJsonDecode(HttpClientResponse response) async {
    final json = await response
        .transform(utf8.decoder)
        .toList()
        .then((value) => value.join())
        .then((value) => jsonDecode(value));
    return json;
  }

  Future<HttpClientResponse> myGet(
      {required String host,
      required String path,
      required Map<String, dynamic>? parameters}) async {
    final url = makeUri(host: host, path: path, parameters: parameters);
    final request = await getUrl(url);
    final response = await request.close();
    return response;
  }
}
