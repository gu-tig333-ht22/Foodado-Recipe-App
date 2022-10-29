import 'package:flutter/material.dart';
import 'package:grupp_5/components/db/recipe_database.dart';
import 'package:grupp_5/components/models/recipe_db_model.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:grupp_5/constants/routes.dart';

class SaveView extends StatefulWidget {
  const SaveView({Key? key}) : super(key: key);

  @override
  State<SaveView> createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  late List<RecipeDb> recipeDb;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshRecipes();
  }

  @override
  void dispose() {
    // RecipeDatabase.instance.close();
    super.dispose();
  }

  Future refreshRecipes() async {
    setState(() => isLoading = true);
    this.recipeDb = await RecipeDatabase.instance.readAllRecipes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                Icons.delete,
                color: Colors.grey,
              ),
              onPressed: () async {
                AlertDialog;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete all recipes?'),
                    content: const Text('This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: secondaryColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          await RecipeDatabase.instance.deleteAll();
                          Navigator.of(context).pop();
                          refreshRecipes();
                          customSnackbar(context, 'All recipes deleted');
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                refreshRecipes();
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
        body: Center(
          child: isLoading
              ? loadingAnimation
              : recipeDb.isEmpty
                  ? const Text('No saved recipes')
                  : buildRecipes(),
        ),
      );

  Widget buildRecipes() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        return GridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 2,
          children: [
            for (final recipeDb in recipeDb)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    recipe.setRecipeId(recipeDb.id.toString());
                    recipe.getSavedRecipe();
                    Navigator.of(context).pushNamed(recipeSavedViewRoute);
                  },
                  child: Container(
                    width: 300,
                    height: 230,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [shadow],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 300,
                          height: 140,
                          decoration: BoxDecoration(
                            image: //network
                                DecorationImage(
                              image: NetworkImage(recipeDb.image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                        ),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            recipeDb.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
