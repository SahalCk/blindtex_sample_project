part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenEvent {}

class ObscureValueChangedEvenet extends LoginScreenEvent {
  final bool currentValue;

  ObscureValueChangedEvenet({required this.currentValue});
}

class LoginButtonPressedEvent extends LoginScreenEvent {
  final String username;
  final String password;

  LoginButtonPressedEvent({required this.username, required this.password});
}
