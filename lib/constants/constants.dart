import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

const Color primaryColor = Color(0xFFE0E0E0);
const Color secondaryColor = Color.fromRGBO(76, 175, 80, 1);
const Color thirdColor = Color(0x9393939);
const Color fourthColor = Color.fromARGB(255, 0, 0, 0);
const Color fifthColor = Colors.grey;
const Color backgroundColor = Color.fromARGB(255, 255, 255, 255);

BoxShadow shadow = BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  spreadRadius: 5,
  blurRadius: 7,
  offset: const Offset(0, 0),
);

LottieBuilder loadingAnimation = Lottie.asset('assets/loading.json');

void customSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: secondaryColor,
      padding: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(30),
      duration: const Duration(seconds: 2),
    ),
  );
}
