import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/steps_model.dart';
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
  late Future<AnalyzedInstruction> futureAnalyzedInstruction;

  @override
  void initState() {
    super.initState();
    futureRecipe = fetchRecipe();
    futureAnalyzedInstruction = fetchAnalyzedInstruction();
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
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Container();
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          recipeImage(),
          recipeInfo(),
          recipeIngredients(),
          recipeInstructions(),
        ],
      ),
    );
  }

  Widget recipeImage() {
    return FutureBuilder<Recipe>(
        future: futureRecipe,
        builder: (context, snapshot) {
          //if data is not null
          if (snapshot.hasData) {
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
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Container();
        });
  }

  Widget recipeInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Recipe>(
        future: futureRecipe,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget recipeIngredients() {
    return FutureBuilder<Recipe>(
        future: futureRecipe,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                        return Card(
                          child: ListTile(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.check_box_outline_blank_rounded,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                            title: Text(
                              snapshot.data!.extendedIngredients[index],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Container();
        });
  }

  Widget recipeInstructions() {
    return FutureBuilder<AnalyzedInstruction>(
        future: futureAnalyzedInstruction,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
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
                      itemCount: snapshot.data!.steps.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Text(
                              snapshot.data!.steps[index].number.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            title: Text(
                              snapshot.data!.steps[index].step,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Container();
        });
  }
}
