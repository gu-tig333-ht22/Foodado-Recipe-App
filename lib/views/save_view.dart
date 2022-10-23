import 'package:flutter/material.dart';
import 'package:grupp_5/components/db/recipe_database.dart';
import 'package:grupp_5/components/models/recipe_db_model.dart';
import 'package:grupp_5/components/models/recipe_model.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:provider/provider.dart';
import '/constants/routes.dart';

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
                await RecipeDatabase.instance.deleteAll();
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
              Navigator.of(context).pushNamed(devViewRoute);
            },
          ),
        ),
        body: Center(
            child: isLoading
                ? loadingAnimation
                : recipeDb.isEmpty
                    ? const Text('No saved recipes')
                    : buildRecipes()),
      );

  Widget buildRecipes() {
    return GestureDetector(
      onTap: () {
        setState(() {
          Provider.of<RecipeProvider>(context, listen: false).recipeId = '40';
        });

        Navigator.of(context).pushNamed(recipeSavedRoute);
      },
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          for (final recipe in recipeDb)
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                          image: NetworkImage(recipe.image),
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
                        recipe.title,
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
        ],
      ),
    );
  }

  //  Widget recipeTypeFilter() {
//     List<String> recipeType = [
//       'Lunch',
//       'Breakfast',
//       'Dinner',
//       'Dessert',
//     ];
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         for (int i = 0; i < recipeType.length; i++)
//           OutlinedButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: const BorderSide(color: Colors.black),
//                 ),
//               ),
//             ),
//             onPressed: () {},
//             child: Text(
//               recipeType[i],
//               style: const TextStyle(color: secondaryColor),
//             ),
//           ),
//       ],
//     );
//   }

//   Widget searchIncludeIngredients() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           labelText: 'Search for ingredients to include',
//           prefixIcon: const Icon(Icons.search),
//         ),
//       ),
//     );
//   }
}
