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
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(devViewRoute);
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

  Widget pictures() {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(recipeViewRoute),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            for (int i = 0; i < 10; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  height: 230,
                  decoration: const BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        height: 140,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/recipe_image.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      //IMAGE
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Poke Bowl',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
