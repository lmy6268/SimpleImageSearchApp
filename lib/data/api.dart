import 'dart:convert';
import 'package:image_search_app/data/photo_api_repository.dart';

import '../model/Photo.dart';
import 'package:http/http.dart' as http;

class PixabayAPI implements PhotoApiRepository {
  static const String baseUrl = "https://pixabay.com/api/";
  static const String key = "17159641-1bf10cc7b7513d39c89bb809d";

  //{} 는 옵션 인자를 의미한다.
  @override
  Future<List<Photo>> fetch(String query, {http.Client? client}) async {
    client ??= http.Client(); //client가 Null인경우에만, 이렇게 초기화해준다.

    final String url = '$baseUrl?key=$key&q=$query&image_type=photo';
    final response = await client.get(Uri.parse(url));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits']; //아직은 Map 형태
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}
