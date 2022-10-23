import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/models/user/user.dart';
import 'package:mycloud/provider/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;

final loginProvider = StateNotifierProvider<LoginProvider, LoginState>(
  (ref) => LoginProvider(
    ref.read,
  ),
);

class LoginProvider extends StateNotifier<LoginState> {
  LoginProvider(this._reader) : super(const LoginState()) {
    login();
  }
  Future<void> login() async {
    firebase.User? user = firebase.FirebaseAuth.instance.currentUser;
    if (user != null) {
      state = state.copyWith(
          user: state.user.copyWith(email: user.email as String));
    }
  }

  final Reader _reader;
  void changeUser(String email) {
    state = state.copyWith(user: state.user.copyWith(email: email));
  }

  void changeEmail(String email) {
    state = state.copyWith(email: email);
  }

  void changeName(String name) {
    state = state.copyWith(name: name);
  }

  void changePassword(String password) {
    state = state.copyWith(password: password);
  }

  void changeInfoText(String infoText) {
    state = state.copyWith(infoText: infoText);
  }

  void changeMode(bool isLoginMode) {
    state = state.copyWith(isLoginMode: isLoginMode);
  }

  void reset() {
    state = state.copyWith(
        infoText: '', email: '', password: '', name: '', user: const User());
  }
}
