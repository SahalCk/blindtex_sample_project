import 'package:blindtex/utils/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Screen',
            style: TextStyle(
                color: textColor, fontSize: 22, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
