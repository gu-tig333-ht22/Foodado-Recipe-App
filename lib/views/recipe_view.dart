import 'package:flutter/material.dart';
import 'package:grupp_5/constants/constants.dart';
import '/constants/routes.dart';

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

//recipeImage(), recipeInfo(), recipeIngredients(), recipeInstructions()
  Widget recipeImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 350,
        height: 230,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/recipe_image.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget recipeInfo() {
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
              const Text(
                '30 min',
                style: TextStyle(
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
              const Text(
                '2 servings',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//listtiles of ingredients in boxes with checkboxes
  Widget recipeIngredients() {
    List<String> ingredientsList = [
      '2 cups of rice',
      '1 can of tuna',
      '1 avocado',
      '1 cucumber',
      '1 small onion',
      '1 lime',
      '1 tbsp of mayo',
      '1 tbsp of soy sauce',
      '1 tbsp of sesame oil',
    ];
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
                itemCount: ingredientsList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(ingredientsList[index]),
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
