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
        title: "Welcome to the Recipe App",
        body:
            "This app will help you find recipes based on the ingredients you have at home.",
        image: Center(
          child: //lotie
              Lottie.asset('assets/intro_images/recipe_book.json'),
        ),
        decoration: const PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.0,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      PageViewModel(
        title: "How to use the app",
        body:
            "First, you need to enter the ingredients you have at home. Then, you can filter the recipes based on your preferences. Finally, you can save the recipes you like.",
        image: const Center(
          child: Image(
            image: AssetImage('assets/empty.jpg'),
            height: 175.0,
          ),
        ),
        decoration: const PageDecoration(
          pageColor: Colors.white,
          bodyTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.0,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      PageViewModel(
        title: "Let's get started",
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Click on the button below \n to start using the app',
              style: TextStyle(color: Colors.black, fontSize: 19.0),
            ),
          ],
        ),
        image: const Center(
          child: Image(
            image: AssetImage('assets/recipe_image.jpg'),
            height: 175.0,
          ),
        ),
        decoration: const PageDecoration(
          pageColor: Color.fromARGB(75, 58, 180, 28),
          bodyTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 19.0,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
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
        Navigator.of(context).pushNamed('/dev_view');
      },
      showSkipButton: true,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
