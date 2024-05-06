/// 결과나 에러를 담는 객체로 활용할 예정
/// 성공과 실패를 처리할 것

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success;
  const factory Result.error(String e) = Error;
}
