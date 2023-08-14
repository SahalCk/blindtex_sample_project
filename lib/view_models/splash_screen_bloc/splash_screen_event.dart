part of 'splash_screen_bloc.dart';

@immutable
sealed class SplashScreenEvent {}

class CheckIsAlreadyLoggedIn extends SplashScreenEvent {}
