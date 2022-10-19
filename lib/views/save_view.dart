import 'package:flutter/material.dart';
import 'package:grupp_5/components/db/recipe_database.dart';
import 'package:grupp_5/components/models/recipe_model.dart';
import 'package:grupp_5/constants/constants.dart';
import '/constants/routes.dart';

class SaveView extends StatefulWidget {
  const SaveView({Key? key}) : super(key: key);

  @override
  State<SaveView> createState() => _SaveViewState();
}

class _SaveViewState extends State<SaveView> {
  late List<Recipe> recipes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshRecipes();
  }

  @override
  void dispose() {
    RecipeDatabase.instance.close();

    super.dispose();
  }

  Future refreshRecipes() async {
    setState(() => isLoading = true);
    this.recipes = await RecipeDatabase.instance.readAllRecipes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'recipe',
            style: TextStyle(fontSize: 24),
          ),
          actions: [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : recipes.isEmpty
                  ? Text(
                      'No recipe',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildrecipe(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () async {},
        ),
      );

  Widget buildrecipe() => ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: recipes.length,
        itemBuilder: (BuildContext context, int index) {
          final recipe = recipes[index];

          return Dismissible(
            key: ValueKey(recipe.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Spacer(),
                  Icon(Icons.delete, color: Colors.white),
                ],
              ),
            ),
            onDismissed: (direction) async {
              await RecipeDatabase.instance.delete(recipe.id);
              refreshRecipes();
            },
            child: Card(
              color: Colors.black,
              child: ListTile(
                title: Text(
                  recipe.title,
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                subtitle: Text(
                  recipe.title,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          );
        },
      );
}
