import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycloud/models/point.dart';
part 'point_state.freezed.dart';

@freezed
class PointState with _$PointState {
  const factory PointState({
    @Default(Point()) Point point,
  }) = _PointState;
}
