import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mycloud/models/user/user.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default('') String infoText,
    @Default('') String email,
    @Default('') String password,
    @Default('名前未設定') String name,
    @Default(true) bool isLoginMode,
    @Default(User()) User user,
  }) = _LoginState;
}
