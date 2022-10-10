import 'package:flutter/material.dart';
import 'package:grupp_5/constants/constants.dart';
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
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Saved Recipes',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh_rounded,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(mainViewRoute);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              searchIncludeIngredients(),
              recipeTypeFilter(),
              pictures(),
            ],
          ),
        ));
  }

  Widget recipeTypeFilter() {
    List<String> recipeType = [
      'Lunch',
      'Breakfast',
      'Dinner',
      'Dessert',
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < recipeType.length; i++)
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              recipeType[i],
              style: const TextStyle(color: secondaryColor),
            ),
          ),
      ],
    );
  }

  Widget searchIncludeIngredients() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: 'Search for ingredients to include',
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

Widget pictures() {
  return Expanded(
    child: GridView.count(
      crossAxisCount: 2,
      children: [
        for (int i = 0; i < 4; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage('assets/recipe_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      ],
    ),
  );
}
