import 'package:image_search_app/data/data_source/pixabay_api.dart';
import 'package:image_search_app/domain/repository/photo_api_repository.dart';

import '../../domain/model/photo.dart';
import '../data_source/result.dart';

class PhotoApiRepositoryImpl implements PhotoApiRepository {
  PixabayApi api;

  PhotoApiRepositoryImpl(this.api);

  static const String baseUrl = "https://pixabay.com/api/";
  static const String key = "17159641-1bf10cc7b7513d39c89bb809d";

  //{} 는 옵션 인자를 의미한다.
  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    final Result<Iterable> res = await api.fetch(query);
    return res.when(success: (data) {
      return Result.success(data.map((e) => Photo.fromJson(e)).toList());
    }, error: (message) {
      return Result.error(message);
    });
  }
}
