part of 'splash_screen_bloc.dart';

@immutable
sealed class SplashScreenState {}

final class SplashScreenInitial extends SplashScreenState {}

abstract class SplashScreenActionState extends SplashScreenState {}

class NavigateToHomeScreenState extends SplashScreenActionState {}

class NavigateToLoginScreenState extends SplashScreenActionState {}
