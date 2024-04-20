import 'package:flutter/material.dart';
import 'package:image_search_app/data/api.dart';

import '../ui/home_view_model.dart';

/// InheritedWidget 객체는 내부에 불변객체만 담을 수 있도록 설계되어 있다.
class PhotoProvider extends InheritedWidget {
  final HomeViewModel homeViewModel;

  const PhotoProvider(this.homeViewModel, {super.key, required super.child});

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
    return true;
  }
}
