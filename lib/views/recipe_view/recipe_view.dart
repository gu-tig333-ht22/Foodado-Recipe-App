import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:grupp_5/components/models/steps_model.dart';
import 'package:grupp_5/components/models/recipe_db_model.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:grupp_5/components/db/recipe_database.dart';

bool checked = false;

class RecipeView extends StatefulWidget {
  const RecipeView({Key? key}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late List<RecipeDb> recipeDb;
  bool isLoading = false;
  bool summaryExpanded = true;
  bool ingredientsExpanded = false;
  bool instructionsExpanded = false;

  @override
  void initState() {
    super.initState();
    delay();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future delay() async {
    setState(() => isLoading = true);
    this.recipeDb = await RecipeDatabase.instance.readAllRecipes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Consumer<RecipeProvider>(
          builder: (context, recipe, child) {
            if (recipe.filterRecipe == null) {
              return const Text(
                'Recipe',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Text(
                recipe.recipes.last.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            }
          },
        ),
        actions: [
          Consumer<RecipeProvider>(
            builder: (context, recipe, child) {
              if (recipe.filterRecipe == null) {
                return Container();
              } else {
                return IconButton(
                  onPressed: () {
                    setState(
                      () {
                        recipe.setIsFavorite();
                        if (recipe.recipes.last.isFavorite == true) {
                          RecipeDatabase.instance.create(
                            RecipeDb(
                              recipe.recipes.last.id,
                              recipe.recipes.last.title,
                              recipe.recipes.last.image,
                            ),
                          );
                          customSnackbar(context, 'Recipe saved');
                        } else {
                          RecipeDatabase.instance.delete(
                            recipe.recipes.last.id,
                          );
                          customSnackbar(context, 'Recipe deleted');
                        }
                      },
                    );
                  },
                  icon: recipe.recipes.last.isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: secondaryColor,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                );
              }
            },
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
      body: isLoading
          ? loadingAnimation
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  recipeImage(),
                  recipeInfo(),
                  recipeSummary(),
                  recipeIngredients(),
                  recipeInstructions(),
                ],
              ),
            ),
    );
  }

  Widget recipeImage() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe?.results == null) {
          return Center(
            child: Container(),
          );
        } else {
          return Container(
            width: 320,
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(recipe.recipes.last.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        }
      },
    );
  }

// make the recipeingredients widget collapsable

  Widget recipeInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<RecipeProvider>(
        builder: (context, recipe, child) {
          if (recipe.filterRecipe != null) {
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
                      '${recipe.recipes.last.readyInMinutes} min',
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
                      '${recipe.recipes.last.servings} servings',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: loadingAnimation);
          }
        },
      ),
    );
  }

  //recipeSummary() with expansionTile
  Widget recipeSummary() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe != null) {
          return Padding(
            padding: const EdgeInsets.only(right: 3, left: 3),
            child: ExpansionTile(
              textColor: Colors.black,
              title: const Text(
                'Summary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Html(data: recipe.recipes.last.summary),
              ],
            ),
          );
        } else {
          return Center(child: loadingAnimation);
        }
      },
    );
  }

  Widget recipeIngredients() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe != null) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 3, left: 3),
                  child: ExpansionTile(
                    textColor: Colors.black,
                    title: const Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //toggleExpanded
                    onExpansionChanged: (value) {
                      setState(() {
                        ingredientsExpanded = value;
                      });
                    },
                  ),
                ),
                ingredientsExpanded
                    ? Container()
                    : ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 0,
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              recipe.recipes.last.extendedIngredients.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Checkbox(
                                  activeColor: secondaryColor,
                                  value:
                                      recipe.recipes.last.ingredientDone[index],
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        recipe.recipes.last
                                            .ingredientDone[index] = value!;
                                      },
                                    );
                                  },
                                ),
                                title: Html(
                                  data: recipe
                                      .recipes.last.extendedIngredients[index],
                                  style: {
                                    '#': Style(
                                      fontSize: const FontSize(14),
                                    ),
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget recipeInstructions() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe != null) {
          return ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 3, left: 3),
                  child: ExpansionTile(
                    textColor: Colors.black,
                    title: const Text(
                      'Instructions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onExpansionChanged: (value) {
                      setState(
                        () {
                          instructionsExpanded = value;
                        },
                      );
                    },
                  ),
                ),
                instructionsExpanded
                    ? Container()
                    : ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 0,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: recipe.recipes.last.steps.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Text(
                                  recipe.recipes.last.steps[index].number
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                title: Html(
                                  data: recipe.recipes.last.steps[index].step,
                                  style: {
                                    '#': Style(
                                      fontSize: const FontSize(14),
                                    ),
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
