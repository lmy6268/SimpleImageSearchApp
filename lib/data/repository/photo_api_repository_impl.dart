import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/domain/repository/photo_api_repository.dart';

import '../../domain/model/photo.dart';


class PhotoApiRepositoryImpl implements PhotoApiRepository {
  PixabayApi api;

  PhotoApiRepositoryImpl(this.api);

  static const String baseUrl = "https://pixabay.com/api/";
  static const String key = "17159641-1bf10cc7b7513d39c89bb809d";

  //{} 는 옵션 인자를 의미한다.
  @override
  Future<List<Photo>> fetch(String query) async {
    final res = await api.fetch(query);
    return res.map((e) => Photo.fromJson(e)).toList();
  }
}
