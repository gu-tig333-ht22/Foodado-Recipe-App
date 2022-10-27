import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:grupp_5/components/models/steps_model.dart';
import 'package:grupp_5/components/models/recipe_db_model.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:grupp_5/constants/routes.dart';
import 'package:provider/provider.dart';
import 'package:grupp_5/components/db/recipe_database.dart';

bool checked = false;

class RecipeSavedView extends StatefulWidget {
  const RecipeSavedView({Key? key}) : super(key: key);

  @override
  State<RecipeSavedView> createState() => _RecipeSavedViewState();
}

class _RecipeSavedViewState extends State<RecipeSavedView> {
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
    // RecipeDatabase.instance.close();
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
            if (recipe.savedRecipe == null) {
              return const Text(
                'Recipe',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            } else {
              return Text(
                recipe.savedRecipe!.title,
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
              if (recipe.savedRecipe == null) {
                return IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
                );
              } else {
                return IconButton(
                    onPressed: () {
                      setState(() {
                        RecipeDatabase.instance.delete(recipe.savedRecipe!.id);

                        Navigator.of(context).popAndPushNamed(saveViewRoute);
                      });
                    },
                    icon: const Icon(Icons.delete, color: Colors.grey));
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
              physics: BouncingScrollPhysics(),
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
        if (recipe.savedRecipe == null) {
          return Center(child: Container());
        } else {
          return Container(
            width: 320,
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(recipe.savedRecipe!.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        }
      },
    );
  }

  Widget recipeInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<RecipeProvider>(
        builder: (context, recipe, child) {
          if (recipe.savedRecipe != null) {
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
                      '${recipe.savedRecipe!.readyInMinutes} min',
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
                      '${recipe.savedRecipe!.servings} servings',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget recipeSummary() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.savedRecipe != null) {
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
                Html(data: recipe.savedRecipe!.summary),
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
        if (recipe.savedRecipe != null) {
          return ConstrainedBox(
            constraints: BoxConstraints(
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
                              recipe.savedRecipe!.extendedIngredients.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Checkbox(
                                  activeColor: secondaryColor,
                                  value:
                                      recipe.savedRecipe!.ingredientDone[index],
                                  onChanged: (value) {
                                    setState(() {
                                      recipe.savedRecipe!
                                          .ingredientDone[index] = value!;
                                    });
                                  },
                                ),
                                title: Html(
                                  data: recipe
                                      .savedRecipe!.extendedIngredients[index],
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

//toggleExpanded

  Widget recipeInstructions() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.savedRecipe != null) {
          return ConstrainedBox(
            constraints: BoxConstraints(
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
                        constraints: BoxConstraints(
                          minHeight: 0,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: recipe.savedRecipe!.steps.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Text(
                                  recipe.savedRecipe!.steps[index].number
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                title: Html(
                                  data: recipe.savedRecipe!.steps[index].step,
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
