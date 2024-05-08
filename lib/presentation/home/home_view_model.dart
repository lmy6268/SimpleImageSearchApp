import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/repository/photo_api_repository_impl.dart';
import 'package:image_search_app/domain/repository/photo_api_repository.dart';
import 'package:image_search_app/domain/use_case/get_photos_use_case.dart';
import 'package:image_search_app/presentation/home/home_state.dart';
import 'package:image_search_app/presentation/home/home_ui_event.dart';

import '../../data/data_source/result.dart';
import '../../domain/model/photo.dart';

//with 키워드는 의미상 MixIn 기능을 사용할 때 사용한다. -> 상속이랑 의미가 거의 동일하다.
class HomeViewModel with ChangeNotifier {
  final GetPhotosUseCase getPhotosUseCase;
  HomeState _state = HomeState([], false);

  HomeState get state => _state;
  final _eventController = StreamController<HomeUiEvent>();

  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  /// Stream 사용 시
  // //내부적으로 사용
  // final _photoStreamController = StreamController<List<Photo>>()..add([]); //객체 생성 시, 특정 메소드를 실행한 이후의 결과값을 저장할 떄 .. 을 이용한다.
  // //외부에서는 이 컨트롤러를 통해 데이터 상태의 변화를 감지한다.
  // Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  HomeViewModel(this.getPhotosUseCase);

  //Async이기 때문에 결과값은 Future 클래스의 인스턴스로 반환된다.
  Future<void> fetch(String query) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners(); //상태가 변했음을 알려주어야 한다.

    final Result<List<Photo>> result = await getPhotosUseCase(query);
    result.when(
      success: (photos) {
        _state = state.copyWith(photos: photos);
        //ChangeNotifier 기능 이용 -> 이 데이터를 감시중인 데이터에 알림을 보내줌
        notifyListeners();

        /// Stream 적용 시,
        // _photoStreamController.add(result);
      },
      error: (message) {
        //외부로 메시지를 노출시킨다.
        _eventController.add(HomeUiEvent.showSnackBar(message));
      },
    );
    _state = state.copyWith(isLoading: false);
    notifyListeners(); //상태가 변했음을 알려주어야 한다.
  }
}
