import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/photo_api_repository_impl.dart';
import 'package:image_search_app/domain/repository/photo_api_repository.dart';
import 'package:image_search_app/presentation/home/home_ui_event.dart';

import '../../data/data_source/result.dart';
import '../../domain/model/photo.dart';

//with 키워드는 의미상 MixIn 기능을 사용할 때 사용한다. -> 상속이랑 의미가 거의 동일하다.
class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository repo;
  List<Photo> _photos = [];

  ///내부에서만 데이터를 조작할 수 있도록 getter를 만들어준다.
  ///그냥 [List]로만 선언하면, remove, add, clear 메소드를 적용가능한 문제가 있다.  -> [UnmodifiableListView]를 이용하여 적용하기!! (수정 불가 리스트)
  UnmodifiableListView<Photo> get photos => UnmodifiableListView(_photos);

  final _eventController = StreamController<HomeUiEvent>();

  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  /// Stream 사용 시
  // //내부적으로 사용
  // final _photoStreamController = StreamController<List<Photo>>()..add([]); //객체 생성 시, 특정 메소드를 실행한 이후의 결과값을 저장할 떄 .. 을 이용한다.
  // //외부에서는 이 컨트롤러를 통해 데이터 상태의 변화를 감지한다.
  // Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  HomeViewModel(this.repo);

  //Async이기 때문에 결과값은 Future 클래스의 인스턴스로 반환된다.
  Future<void> fetch(String query) async {
    final Result<List<Photo>> result = await repo.fetch(query);
    result.when(success: (photos) {
      _photos = photos;
      //ChangeNotifier 기능 이용 -> 이 데이터를 감시중인 데이터에 알림을 보내줌
      notifyListeners();

      /// Stream 적용 시,
      // _photoStreamController.add(result);
    }, error: (message) {
      //외부로 메시지를 노출시킨다.
      _eventController.add(HomeUiEvent.showSnackBar(message));
    });
  }
}