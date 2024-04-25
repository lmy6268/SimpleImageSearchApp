// import 'package:equatable/equatable.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'photo.g.dart';
//
// //Equatable을 상속받게 되면, 해당 객체는 [불변객체]로 보아야한다.
//
// /// [L11] 불변 객체
// /// 장점
// /// - 오류 발생률이 줄어든다 ( 상수 데이터를 이용하다보니 )
// /// 단점
// /// - 특정 변수의 데이터 수정 요청을 들어줄 수 없게 된다. -> 객체를 복사한 후 값을 변경해야 하는 번거로움
// /// - 값을 복사하기 위해, 별도의 함수를 직접 만들어 줘야 한다.  => [Freezed] 라이브러리를 이용하여 제작한다.
//
// @JsonSerializable()
// class Photo extends Equatable {
//   final int id;
//   final String tags;
//
//   @JsonKey(name: 'previewURL')
//   final String previewUrl;
//
//   const Photo({required this.id, required this.tags, required this.previewUrl});
//
//   factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PhotoToJson(this);
//
//   ///Equatable 라이브러리를 이용해서 동일한 객체인지 여부를 판단하도록 한다.
//   /// 라이브러리를 사용하는 이유
//   /// -> 휴먼 에러를 조금이나마 방지하기 위해서
//   @override
//   List<Object?> get props => [id];
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.g.dart';
part 'photo.freezed.dart';

@freezed
class Photo with _$Photo {
  factory Photo({
    required int id,
    required String tags,
    required String previewURL,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
