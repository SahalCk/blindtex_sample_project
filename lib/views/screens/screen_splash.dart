import 'package:blindtex/utils/colors.dart';
import 'package:blindtex/view_models/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:blindtex/views/screens/screen_home.dart';
import 'package:blindtex/views/screens/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<SplashScreenBloc>(context).add(CheckIsAlreadyLoggedIn());
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          SystemUiOverlayStyle.light.copyWith(statusBarColor: backgroundColor),
      child: BlocListener<SplashScreenBloc, SplashScreenState>(
        listenWhen: (previous, current) => current is SplashScreenActionState,
        listener: (context, state) {
          if (state is NavigateToHomeScreenState) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return const HomeScreen();
              },
            ));
          } else if (state is NavigateToLoginScreenState) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return const LoginScreen();
              },
            ));
          }
        },
        child: Scaffold(
          body: Center(
            child: Image.asset(
              'assets/logo.png',
              height: Adaptive.h(22),
              width: Adaptive.w(35),
            ),
          ),
        ),
      ),
    );
  }
}
