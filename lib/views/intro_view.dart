import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:grupp_5/constants/routes.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: "Welcome to Foodado",
        body:
            "This app will help you find recipes based on the ingredients you have at home.",
        image: Center(
          child: //lotie
              Lottie.asset('assets/intro_images/recipe_book.json'),
        ),
        decoration: const PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: fourthColor,
            fontSize: 19.0,
          ),
          titleTextStyle: TextStyle(
            color: secondaryColor,
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      PageViewModel(
        title: "How to use the app",
        body:
            "It's simple! Use the filter function to generate recipes based on your own preferences. \n \n Let Foodado do the rest for you!",
        image: Center(
          child: Lottie.asset('assets/intro_images/wondering_woman.json'),
        ),
        decoration: const PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: fourthColor,
            fontSize: 19.0,
          ),
          titleTextStyle: TextStyle(
            color: secondaryColor,
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      PageViewModel(
        //lets get started button with an image
        title: "Let's get started!",
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Click on the ",
              style: TextStyle(fontSize: 19.0, color: fourthColor),
            ),
            Icon(Icons.arrow_forward),
            Text(
              " button to get started!",
              style: TextStyle(fontSize: 19.0, color: fourthColor),
            ),
          ],
        ),
        image: Center(
          child: Lottie.asset(
            'assets/intro_images/chef.json',
          ),
        ),
        decoration: const PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: secondaryColor,
            fontSize: 19.0,
          ),
          titleTextStyle: TextStyle(
            color: secondaryColor,
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: getPages(),
      onDone: () {
        Navigator.of(context).pushNamed(scrambleViewRoute);
      },
      showSkipButton: true,
      skip: const Text(
        'Skip',
        style: TextStyle(
          color: fourthColor,
        ),
      ),
      next: const Icon(
        Icons.arrow_forward,
        color: fourthColor,
      ),
      done: const Icon(
        Icons.arrow_forward,
        color: fourthColor,
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: fifthColor,
        activeSize: Size(22.0, 10.0),
        activeColor: secondaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
