import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/api_service.dart';
import 'package:grupp_5/components/models/recipe_model.dart';
import 'package:grupp_5/components/models/steps_model.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '/constants/routes.dart';
import 'package:flutter_html/flutter_html.dart';

class ScrambleView extends StatefulWidget {
  const ScrambleView({Key? key}) : super(key: key);

  @override
  State<ScrambleView> createState() => _ScrambleViewState();
}

class _ScrambleViewState extends State<ScrambleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Recipes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.sort,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(filterViewRoute);
          },
        ),
      ),
      // bottomNavigationBar: bottomNavigationBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            recipeCard(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: nextRecipeButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

//recipecard with assets/recipe_image.jpg
  Widget recipeCard() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.recipe != null) {
          return GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(recipeViewRoute),
            child: Container(
              width: 350,
              height: 490,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [shadow],
              ),
              child: Column(
                children: [
                  Container(
                    width: 350,
                    height: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(recipe.recipe!.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            recipe.recipe!.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Html(
                            data: recipe.recipe!.summary,
                            style: {
                              '#': Style(
                                textAlign: TextAlign.center,
                                fontSize: const FontSize(16),
                                maxLines: 6,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            },
                          ),

                          //cooking time, difficulty, servings
                          Padding(
                            //padding top
                            padding: const EdgeInsets.only(top: 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      color: secondaryColor.withOpacity(0.4),
                                    ),
                                    Text(
                                      '${recipe.recipe!.readyInMinutes} min',
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
                                      '${recipe.recipe!.servings} servings',
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

//
//next recipe button
  Widget nextRecipeButton() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.recipe != null) {
          return GestureDetector(
            onTap: () {
              setState(() {
                apiId = Random().nextInt(5000);
                recipe.fetchRecipe();
                recipe.fetchAnalyzedInstruction();
              });
            },
            child: Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [shadow],
              ),
              child: const Center(
                child: Text(
                  'Next recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

//bottom navigation bar with save button home button
  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
      ],
      selectedItemColor: secondaryColor,
    );
  }
}
