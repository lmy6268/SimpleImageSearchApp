//fetch가 제대로 동작하는지 확인

import 'package:flutter_test/flutter_test.dart';
import 'package:image_search_app/data/data_source/result.dart';
import 'package:image_search_app/domain/repository/photo_api_repository.dart';
import 'package:image_search_app/domain/model/photo.dart';
import 'package:image_search_app/domain/use_case/get_photos_use_case.dart';
import 'package:image_search_app/presentation/home/home_view_model.dart';

void main() {
  test('Stream이 잘 동작해야 한다', () async {
    //API에 의존하고 있는 상태 -> 만약 API가 동작하지 않는다면 테스트도 정상적으로 되지 않을 것이다.
    //의존되는 부분 -> 인터페이스로 전환
    final viewModel = HomeViewModel(GetPhotosUseCase(FakePhotoApiRepository()));

    final res = fakeJson.map((e) => Photo.fromJson(e)).toList();

    await viewModel.fetch('apple');

    //기대값과 실제값 확인하기
    expect(viewModel.state.photos, res);
  });
}

class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<Result<List<Photo>>> fetch(String query) async {
    Future.delayed(const Duration(microseconds: 500));
    return Result.success(fakeJson.map((e) => Photo.fromJson(e)).toList());
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 8595521,
    "pageURL": "https://pixabay.com/photos/forsythia-flowers-branch-8595521/",
    "type": "photo",
    "tags": "forsythia, flowers, branch",
    "previewURL":
        "https://cdn.pixabay.com/photo/2024/02/25/10/11/forsythia-8595521_150.jpg",
    "previewWidth": 112,
    "previewHeight": 150,
    "webformatURL":
        "https://pixabay.com/get/g80a1350f78b3cd277c4c231175b3950d2014f5f5b8f57d37eb1f4e580437b3971ce416a60314df8af9dd08da3bd28ef4147ee3723640d2844adc9f6ac2a970bb_640.jpg",
    "webformatWidth": 480,
    "webformatHeight": 640,
    "largeImageURL":
        "https://pixabay.com/get/g2cc05b5eb7ab92531493a11fab5a29df9a2b6cb3adfe7e8f1421207235faecb1df9f58ac77aec160817679fe50156bc6929389aa984270ab1154c1771539e425_1280.jpg",
    "imageWidth": 3024,
    "imageHeight": 4032,
    "imageSize": 970371,
    "views": 76434,
    "downloads": 62679,
    "collections": 215,
    "likes": 1051,
    "comments": 45,
    "user_id": 10328767,
    "user": "Mylene2401",
    "userImageURL":
        "https://cdn.pixabay.com/user/2020/08/02/06-54-24-533_250x250.jpeg"
  },
  {
    "id": 3063284,
    "pageURL":
        "https://pixabay.com/photos/rose-flower-petal-floral-noble-3063284/",
    "type": "photo",
    "tags": "rose, flower, petal",
    "previewURL":
        "https://cdn.pixabay.com/photo/2018/01/05/16/24/rose-3063284_150.jpg",
    "previewWidth": 150,
    "previewHeight": 99,
    "webformatURL":
        "https://pixabay.com/get/ge31aa66eb870d4c55e95b68c560b7f0b90ea93ad081e10861bc09b4ac7b97e7cb0a857e4a28a7ca054893fa57af2d8c4f5f9ab3aa30869890421ca9118f66b1f_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 426,
    "largeImageURL":
        "https://pixabay.com/get/g0be0c6c99a2860584b9b6ed6a238478eeb290432270f053c1fad4c078834f147500c56b28c4f81dc5ca2e62d012e5635bca693506ebd5eb037db58f9e8b557de_1280.jpg",
    "imageWidth": 6000,
    "imageHeight": 4000,
    "imageSize": 3574625,
    "views": 1195007,
    "downloads": 782062,
    "collections": 1616,
    "likes": 1744,
    "comments": 351,
    "user_id": 1564471,
    "user": "anncapictures",
    "userImageURL":
        "https://cdn.pixabay.com/user/2015/11/27/06-58-54-609_250x250.jpg"
  },
  {
    "id": 8515123,
    "pageURL":
        "https://pixabay.com/photos/bee-flower-yellow-apricot-apricot-8515123/",
    "type": "photo",
    "tags": "bee, beautiful flowers, flower wallpaper",
    "previewURL":
        "https://cdn.pixabay.com/photo/2024/01/17/17/22/bee-8515123_150.jpg",
    "previewWidth": 99,
    "previewHeight": 150,
    "webformatURL":
        "https://pixabay.com/get/gd71ddb5f47ddad02fee20197d1ca650bbb51fc4cca581abb5da7dc10f68debf6679abb38d0b482e91c97ff9d646d34804f0edb10785880eec6b915b95b447569_640.jpg",
    "webformatWidth": 424,
    "webformatHeight": 640,
    "largeImageURL":
        "https://pixabay.com/get/g5059c410ddbfbd7b06333247082989fc73006e7959a5c1d1c147a7f7696c591ddbd0d2952ccc75cb08e900f9045e33a0aa9ff10a9da420c8352634ec497b9f7f_1280.jpg",
    "imageWidth": 3264,
    "imageHeight": 4928,
    "imageSize": 2799308,
    "views": 8963,
    "downloads": 6440,
    "collections": 29,
    "likes": 109,
    "comments": 19,
    "user_id": 23329472,
    "user": "achildinthewood",
    "userImageURL": ""
  },
];
