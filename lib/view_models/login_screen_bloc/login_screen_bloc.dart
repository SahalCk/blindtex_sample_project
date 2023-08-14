// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:convert';
import 'package:blindtex/services/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitial()) {
    on<ObscureValueChangedEvenet>(obscureValueChangedEvenet);
    on<LoginButtonPressedEvent>(loginButtonPressedEvent);
  }

  FutureOr<void> obscureValueChangedEvenet(
      ObscureValueChangedEvenet event, Emitter<LoginScreenState> emit) {
    final currentValue = event.currentValue;

    if (currentValue == false) {
      emit(ObscureValueChangedState(currentObscureValue: true));
    } else {
      emit(ObscureValueChangedState(currentObscureValue: false));
    }
  }

  FutureOr<void> loginButtonPressedEvent(
      LoginButtonPressedEvent event, Emitter<LoginScreenState> emit) async {
    try {
      emit(LoadingState());
      const storage = FlutterSecureStorage();
      final _token = await storage.read(key: 'token');
      final response = await APIServices()
          .loginAPIWithToken(event.username, event.password, _token!);
      final tempstatus = await response.stream.bytesToString();
      final status = jsonDecode(tempstatus) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        if (status['status'] == 'ERROR') {
          if (status['error_code'] == '7153') {
            emit(EmptyUserNameState());
          } else if (status['error_code'] == '6271') {
            emit(EmptyPasswordState());
          } else if (status['error_code'] == '5435') {
            emit(WrongAccessTokenState());
          } else if (status['error_code'] == '4897') {
            emit(InvalidUserNameAndPasswordState());
          } else {
            emit(SomethingWentWrongState(error: 'Something went wrong'));
          }
        } else {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setBool('isAlreadyLoggedIn', true);
          emit(NavigateToHomeScreenState());
        }
      } else {
        emit(SomethingWentWrongState(error: 'Something went wrong'));
      }
    } catch (e) {
      emit(SomethingWentWrongState(error: e.toString()));
    }
  }
}
