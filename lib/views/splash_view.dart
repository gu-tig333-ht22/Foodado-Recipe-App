import 'package:flutter/material.dart';
import '/constants/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Splash View',
          ),
        ),
      ),
      body: Center(
        //buttons to navigate to other views
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(scrambleViewRoute);
              },
              child: Text('Scramble View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(recipeViewRoute);
              },
              child: Text('Recipe View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(filterViewRoute);
              },
              child: Text('Filter View'),
            ),
          ],
        ),
      ),
    );
  }
}
