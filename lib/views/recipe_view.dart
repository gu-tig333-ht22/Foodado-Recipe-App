import 'package:flutter/material.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:provider/provider.dart';
import '/constants/routes.dart';

import '../components/models/recipe_model.dart';

class RecipeView extends StatefulWidget {
  const RecipeView({Key? key}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late Future<Recipe> futureRecipe;

  @override
  void initState() {
    super.initState();
    futureRecipe = fetchRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: FutureBuilder<Recipe>(
          future: futureRecipe,
          builder: (context, snapshot) {
            return Text(
              snapshot.data!.title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        actions: [
          //reset filter button
          IconButton(
            icon: const Icon(
              Icons.favorite_border_rounded,
              color: Colors.black,
            ),
            onPressed: () {}, // add to favorites
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<Recipe>(
          future: futureRecipe,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  recipeImage(),
                  recipeInfo(),
                  recipeIngredients(),
                  recipeInstructions(),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget recipeImage() {
    return FutureBuilder<Recipe>(
        future: futureRecipe,
        builder: (context, snapshot) {
          return Container(
            width: 320,
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(snapshot.data!.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        });
  }

  Widget recipeInfo() {
//recipe info with futurebuilder

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Recipe>(
        future: futureRecipe,
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    color: secondaryColor.withOpacity(0.4),
                  ),
                  Text(
                    '${snapshot.data!.readyInMinutes} min',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.people,
                    color: secondaryColor.withOpacity(0.4),
                  ),
                  Text(
                    snapshot.data!.servings.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget recipeIngredients() {
    //list of extendedIngredients name futurebuilder
    return FutureBuilder<Recipe>(
        future: futureRecipe,
        builder: (context, snapshot) {
          return Expanded(
            child: Column(
              children: [
                const Text(
                  'Ingredients',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.extendedIngredients.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          value: false,
                          onChanged: (value) {},
                        ),
                        title: Text(
                          snapshot.data!.extendedIngredients[index],
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget recipeInstructions() {
    List<String> instructionsList = [
      'Cook the rice',
      'Chop the cucumber, avocado, onion and lime',
      'Mix the mayo, soy sauce and sesame oil',
      'Mix all the ingredients together',
      'Enjoy!',
    ];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            const Text(
              'Instructions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: instructionsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(instructionsList[index]),
                      leading: Text(
                        '${index + 1}.',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
