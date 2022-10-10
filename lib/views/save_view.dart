import 'package:flutter/material.dart';

import '/constants/routes.dart';

class SaveView extends StatefulWidget {
  const SaveView({Key? key}) : super(key: key);

  @override
  State<SaveView> createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Saved recipes',
        ),
      ),
      body: Center(
        //buttons to navigate to other views
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
