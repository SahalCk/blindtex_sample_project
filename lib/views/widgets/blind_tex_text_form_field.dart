import 'package:blindtex/utils/colors.dart';
import 'package:blindtex/view_models/login_screen_bloc/login_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BlindTexTextField extends StatelessWidget {
  final String hint;
  final Icon? prefixIcon;
  final String fieldName;
  final int? limit;
  final TextEditingController controller;

  const BlindTexTextField(
      {super.key,
      required this.hint,
      this.prefixIcon,
      required this.fieldName,
      this.limit,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        maxLines: 1,
        inputFormatters: [LengthLimitingTextInputFormatter(limit)],
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: Adaptive.h(2)),
            prefixIcon: Padding(
              padding:
                  EdgeInsets.only(left: Adaptive.w(2), right: Adaptive.w(1)),
              child: prefixIcon,
            ),
            prefixIconColor: primaryColor,
            hintText: hint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: textFormFieldColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide(color: textFormFieldColor)),
            filled: true,
            fillColor: textFormFieldColor,
            hintStyle: TextStyle(color: hintColor)),
        style: const TextStyle(color: textColor));
  }
}

class BlindTexTextFieldPasswordTextFormField extends StatelessWidget {
  final String hint;
  final Icon? prefixIcon;
  final TextEditingController passwordController;

  const BlindTexTextFieldPasswordTextFormField(
      {super.key,
      required this.hint,
      this.prefixIcon,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginScreenBloc, LoginScreenState>(
      buildWhen: (previous, current) => current is! LoginScreenActionState,
      builder: (context, state) {
        bool? currentObscureValue;
        if (state is ObscureValueChangedState) {
          currentObscureValue = state.currentObscureValue;
        }
        return TextField(
          controller: passwordController,
          maxLines: 1,
          obscureText: currentObscureValue ?? true,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: Adaptive.h(2)),
              prefixIcon: Padding(
                padding:
                    EdgeInsets.only(left: Adaptive.w(2), right: Adaptive.w(1)),
                child: prefixIcon,
              ),
              prefixIconColor: primaryColor,
              hintText: hint,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: textFormFieldColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(color: textFormFieldColor)),
              filled: true,
              fillColor: textFormFieldColor,
              hintStyle: TextStyle(color: hintColor),
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: Adaptive.w(1.5)),
                child: InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      BlocProvider.of<LoginScreenBloc>(context).add(
                          ObscureValueChangedEvenet(
                              currentValue: currentObscureValue ?? false));
                    },
                    child: currentObscureValue ?? false
                        ? Icon(
                            Icons.visibility,
                            color: hintColor,
                            size: 23,
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: hintColor,
                            size: 23,
                          )),
              )),
          style: const TextStyle(color: textColor),
        );
      },
    );
  }
}
