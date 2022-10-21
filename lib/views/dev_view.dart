import 'package:flutter/material.dart';
import '/constants/routes.dart';

class DevView extends StatefulWidget {
  const DevView({Key? key}) : super(key: key);

  @override
  State<DevView> createState() => _DevViewState();
}

class _DevViewState extends State<DevView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Development View',
        ),
      ),
      body: Center(
        //buttons to navigate to other views
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(infoViewRoute);
              },
              child: const Text('Info View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(scrambleViewRoute);
              },
              child: const Text('Scramble View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(recipeViewRoute);
              },
              child: const Text('Recipe View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(filterViewRoute);
              },
              child: const Text('Filter View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(saveViewRoute);
              },
              child: const Text('Save View'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(IntroViewRoute);
              },
              child: const Text('Intro view'),
            ),
          ],
        ),
      ),
    );
  }
}
