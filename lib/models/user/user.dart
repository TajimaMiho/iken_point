import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    @Default('') String id,
    @Default('') String email,
    @Default('') String name,
  }) = _User;
}
