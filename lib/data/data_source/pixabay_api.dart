import 'dart:convert';

import 'package:http/http.dart' as http;

typedef Hit = Map<String, dynamic>;

class PixabayApi {
  final http.Client client;

  PixabayApi(this.client);

  static const String baseUrl = "https://pixabay.com/api/";
  static const String key = "17159641-1bf10cc7b7513d39c89bb809d";

  Future<Iterable> fetch(String query) async {
    final String url = '$baseUrl?key=$key&q=$query&image_type=photo';
    final response = await client.get(Uri.parse(url));
    Hit jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits']; //아직은 Map 형태
    return hits;
  }
}
