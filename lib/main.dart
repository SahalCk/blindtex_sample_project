import 'package:blindtex/utils/colors.dart';
import 'package:blindtex/view_models/login_screen_bloc/login_screen_bloc.dart';
import 'package:blindtex/views/screens/screen_splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'view_models/splash_screen_bloc/splash_screen_bloc.dart';

void main() {
  runApp(const BlindTexApp());
}

class BlindTexApp extends StatelessWidget {
  const BlindTexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SplashScreenBloc()),
            BlocProvider(create: (context) => LoginScreenBloc())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BlindTex App',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: textColor, background: backgroundColor),
                useMaterial3: true),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
