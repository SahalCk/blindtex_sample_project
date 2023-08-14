part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenState {}

final class LoginScreenInitial extends LoginScreenState {}

abstract class LoginScreenActionState extends LoginScreenState {}

class ObscureValueChangedState extends LoginScreenState {
  final bool currentObscureValue;
  ObscureValueChangedState({required this.currentObscureValue});
}

class EmptyUserNameState extends LoginScreenActionState {}

class EmptyPasswordState extends LoginScreenActionState {}

class WrongAccessTokenState extends LoginScreenActionState {}

class InvalidUserNameAndPasswordState extends LoginScreenActionState {}

class SomethingWentWrongState extends LoginScreenActionState {
  final String error;
  SomethingWentWrongState({required this.error});
}

class LoadingState extends LoginScreenActionState {}

class NavigateToHomeScreenState extends LoginScreenActionState {}
