import 'package:freezed_annotation/freezed_annotation.dart';
part 'point.freezed.dart';
part 'point.g.dart';

@freezed
class Point with _$Point {
  @JsonSerializable(explicitToJson: true) // ここに一行追加
  const factory Point({
    @Default(0) int usedPoint,
    @Default(0) int point,
    @Default('') String name,
  }) = _Point;

  factory Point.fromJson(Map<String, dynamic> json) => _$PointFromJson(json);
}
