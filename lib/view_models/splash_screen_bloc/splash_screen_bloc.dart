import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<CheckIsAlreadyLoggedIn>(checkIsAlreadyLoggedIn);
  }

  FutureOr<void> checkIsAlreadyLoggedIn(
      CheckIsAlreadyLoggedIn event, Emitter<SplashScreenState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    const storage = FlutterSecureStorage();
    await storage.write(
        key: 'token', value: 'a21804ac83174db575f2eecce7201d51');
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    bool? isLoggedIn = sharedPreferences.getBool('isAlreadyLoggedIn');

    if (isLoggedIn == true) {
      emit(NavigateToHomeScreenState());
    } else {
      emit(NavigateToLoginScreenState());
    }
  }
}
