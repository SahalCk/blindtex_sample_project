import 'package:blindtex/utils/colors.dart';
import 'package:blindtex/utils/sized_boxes.dart';
import 'package:blindtex/utils/text_styles.dart';
import 'package:blindtex/view_models/login_screen_bloc/login_screen_bloc.dart';
import 'package:blindtex/views/screens/screen_home.dart';
import 'package:blindtex/views/widgets/blind_tex_button.dart';
import 'package:blindtex/views/widgets/blind_tex_snack_bars.dart';
import 'package:blindtex/views/widgets/blind_tex_text_form_field.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emialController = TextEditingController();
    final passwordController = TextEditingController();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          SystemUiOverlayStyle.light.copyWith(statusBarColor: backgroundColor),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Adaptive.w(7)),
              child: StreamBuilder<ConnectivityResult>(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, snapshot) {
                  if (snapshot.data != ConnectivityResult.none &&
                      snapshot.data != null) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          sizedBoxHeight90,
                          Align(
                              alignment: Alignment.center,
                              child: Text('Welcome Back !',
                                  style: loginPageTextStyle)),
                          sizedBoxHeight110,
                          Image.asset('assets/logo.png', width: Adaptive.w(40)),
                          sizedBoxHeight100,
                          BlocListener<LoginScreenBloc, LoginScreenState>(
                            listenWhen: (previous, current) =>
                                current is LoginScreenActionState,
                            listener: (context, state) {
                              if (state is EmptyUserNameState) {
                                Navigator.of(context).pop();
                                errorSnackBar(
                                    context, 'Username field is empty');
                              } else if (state is EmptyPasswordState) {
                                Navigator.of(context).pop();
                                errorSnackBar(
                                    context, 'Password field is empty');
                              } else if (state is WrongAccessTokenState) {
                                Navigator.of(context).pop();
                                errorSnackBar(context, 'Wrong access token');
                              } else if (state
                                  is InvalidUserNameAndPasswordState) {
                                Navigator.of(context).pop();
                                errorSnackBar(
                                    context, 'Invalid username and password');
                              } else if (state is SomethingWentWrongState) {
                                Navigator.of(context).pop();
                                errorSnackBar(context, state.error);
                              } else if (state is NavigateToHomeScreenState) {
                                Navigator.of(context).pop();
                                successSnackBar(context, 'Login success');
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              } else if (state is LoadingState) {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            Color.fromARGB(255, 207, 234, 255),
                                        color: primaryColor,
                                        strokeWidth: 6,
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: Column(
                              children: [
                                BlindTexTextField(
                                    hint: 'Enter Username',
                                    prefixIcon:
                                        const Icon(Icons.person, size: 25),
                                    fieldName: 'Email',
                                    controller: emialController),
                                sizedBoxHeight20,
                                BlindTexTextFieldPasswordTextFormField(
                                    hint: 'Enter Password',
                                    prefixIcon:
                                        const Icon(Icons.lock, size: 25),
                                    passwordController: passwordController),
                              ],
                            ),
                          ),
                          sizedBoxHeight120,
                          BlindTexButton(
                              function: () async {
                                BlocProvider.of<LoginScreenBloc>(context).add(
                                    LoginButtonPressedEvent(
                                        username: emialController.text,
                                        password: passwordController.text));
                              },
                              text: 'Log In'),
                          sizedBoxHeight90,
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                        child: Text('No internet Connection',
                            style: TextStyle(color: Colors.red, fontSize: 18)));
                  }
                },
              )),
        ),
      ),
    );
  }
}
