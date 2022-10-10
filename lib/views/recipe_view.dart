import 'package:flutter/material.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:provider/provider.dart';
import '/constants/routes.dart';
import '../components/provider.dart';
import '../components/model.dart';

class RecipeView extends StatefulWidget {
  const RecipeView({Key? key}) : super(key: key);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Poke Bowl', //Name of recipe
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            recipeImage(),
            recipeInfo(),
            recipeIngredients(),
            recipeInstructions(),
          ],
        ),
      ),
    );
  }

  Widget recipeImage() {
    return Consumer<RecipeState>(
      builder: (context, recipes, child) {
        return Container(
          width: 350,
          height: 230,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(recipes.recipes[0].image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        );
      },
    );
  }

//recipeInfo() with consumer RecipeState
  // Widget recipeInfo() {
  //   return Consumer<RecipeState>(
  //     builder: (context, recipes, child) {
  //       return Container(
  //         width: 350,
  //         height: 100,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(20),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey.withOpacity(0.5),
  //               spreadRadius: 5,
  //               blurRadius: 7,
  //               offset: const Offset(0, 3), // changes position of shadow
  //             ),
  //           ],
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 recipes.recipes[0].title,
  //                 style: const TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       const Icon(
  //                         Icons.timer_rounded,
  //                         color: Colors.black,
  //                       ),
  //                       const SizedBox(
  //                         width: 5,
  //                       ),
  //                       Text(
  //                         recipes.recipes[0].readyInMinutes.toString() + ' min',
  //                         style: const TextStyle(
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   Row(
  //                     children: [
  //                       const Icon(
  //                         Icons.attach_money_rounded,
  //                         color: Colors.black,
  //                       ),
  //                       const SizedBox(
  //                         width: 5,
  //                       ),
  //                       Text(
  //                         ' kr',
  //                         style: const TextStyle(
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget recipeInfo() {
    return Consumer<RecipeState>(builder: (context, recipes, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
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
                  recipes.recipes[0].readyInMinutes.toString() + ' min',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Icon(
                  Icons.bolt_rounded,
                  color: secondaryColor.withOpacity(0.4),
                ),

                ///
                /// Kanske byta ut "svårighetsgrad" värdet nedan som passar någon parameter i API:et
                ///

                const Text(
                  'Medium',
                  style: TextStyle(
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
                  recipes.recipes[0].servings.toString() + ' servings',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget recipeIngredients() {
    return Consumer<RecipeState>(builder: (context, recipes, child) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
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
                  itemCount: recipes.recipes[0].extendedIngredients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title:
                            Text(recipes.recipes[0].extendedIngredients[index]),
                        leading: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          value: false,
                          onChanged: (value) {},
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
