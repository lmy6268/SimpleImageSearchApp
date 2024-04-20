import 'dart:async';

import 'package:image_search_app/data/api.dart';

import '../model/Photo.dart';

class HomeViewModel {
  final PixabayAPI api;

  //내부적으로 사용
  final _photoStreamController = StreamController<List<Photo>>()..add([]); //객체 생성 시, 특정 메소드를 실행한 이후의 결과값을 저장할 떄 .. 을 이용한다.

  //외부에서는 이 컨트롤러를 통해 데이터 상태의 변화를 감지한다.
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  HomeViewModel(this.api);

  //Async이기 때문에 결과값은 Future 클래스의 인스턴스로 반환된다.
  Future<void> fetch(String query) async {
    final result = await api.fetch(query);
    _photoStreamController.add(result);
  }
}
