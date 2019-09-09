import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';

final List<String> mockFunctions = <String>[
  'SubList1',
  'SubList2',
  'SubList3',
  'About'
];

class Api {
  final HttpClient _httpClient = HttpClient();
  final String _aboutUrl = 'about.yiray.dev';

  static List<String> retrieveAllFunctions() {
    return mockFunctions;
  }

  Future<Map<String, dynamic>> retrieveAboutFields() async {
    final Uri uri = Uri.https(_aboutUrl, '/graphql');
    final Map<String, dynamic> jsonResponse = await _post(
        uri,
        _createGraphQLQuery(
            '{ author: user { Author: name label Email: email Website: website } }'));

    if (jsonResponse == null || jsonResponse['data'] == null) {
      print('Error');
      return null;
    }
    return jsonResponse['data'];
  }


  Map<String, String> _createGraphQLQuery(String query) {
    return <String, String>{'query': query};
  }

  Future<Map<String, dynamic>> _post(
      Uri uri, Map<String, String> params) async {
    try {
      final HttpClientRequest request = await _httpClient.postUrl(uri);
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(params)));

      final HttpClientResponse response = await request.close();

      final String responseBody = await response.transform(utf8.decoder).join();

      return json.decode(responseBody);
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }
}
