import 'dart:convert';
import '../model/Photo.dart';
import 'package:http/http.dart' as http;

class PixabayAPI{
  final String baseUrl = "https://pixabay.com/api/";
  final String key = "17159641-1bf10cc7b7513d39c89bb809d";

  Future<List<Photo>> fetch(String query) async {
    final String url =
        '$baseUrl?key=$key&q=$query&image_type=photo';
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits']; //아직은 Map 형태
    return hits.map((e) => Photo.fromJson(e)).toList();
  }
}

