import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_search_app/data/api.dart';

import '../model/Photo.dart';

/// InheritedWidget 객체는 내부에 불변객체만 담을 수 있도록 설계되어 있다.
class PhotoProvider extends InheritedWidget {
  final PixabayAPI api;

  PhotoProvider({super.key, required super.child, required this.api});

//내부적으로 사용
  final _photoStreamController = StreamController<List<Photo>>()..add([]); //객체 생성 시, 특정 메소드를 실행한 이후의 결과값을 저장할 떄 .. 을 이용한다.

  //외부에서는 이 컨트롤러를 통해 데이터 상태의 변화를 감지한다.
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  /// of 메소드를 통해 어디서든  PhotoProvider를 제공받을 수 있도록 한다 .
  static PhotoProvider of(BuildContext context) {
    //현재 위젯 트리와 가장 가까운 곳에 있는 PhotoProvider 객체를 찾아서 리턴해준다.
    final PhotoProvider? result = context.dependOnInheritedWidgetOfExactType();
    //만약 못 찾은 경우, 에러를 표시하고 종료.
    assert(result != null, "NO PixabayAPI found in context.");
    return result!;
  }

  // PixabayAPI가 변경이 되는 경우, 다시 새롭게 전달해주는 규칙을 정하는 메소드
  // [covariant] : 이름을 마음대로 바꿔도 된다는 의미의 키워드
  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return oldWidget.api != api;
  }

  //Async이기 때문에 결과값은 Future 클래스의 인스턴스로 반환된다.
  Future<void> fetch(String query) async {
    final result = await api.fetch(query);
    _photoStreamController.add(result);
  }
}
