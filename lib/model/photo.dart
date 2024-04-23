import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

//Equatable을 상속받게 되면, 해당 객체는 불변객체로 보아야한다.
@JsonSerializable()
class Photo extends Equatable {
  final int id;
  final String tags;

  @JsonKey(name: 'previewURL')
  final String previewUrl;

  const Photo({required this.id, required this.tags, required this.previewUrl});

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  ///Equatable 라이브러리를 이용해서 동일한 객체인지 여부를 판단하도록 한다.
  /// 라이브러리를 사용하는 이유
  /// -> 휴먼 에러를 조금이나마 방지하기 위해서
  @override
  List<Object?> get props => [id];
}
