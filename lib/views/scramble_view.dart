import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '/constants/routes.dart';

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
        backgroundColor: backgroundColor,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Recipes',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            //mainView
            Navigator.of(context).pushNamed(mainViewRoute);
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
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
}

//recipecard with assets/recipe_image.jpg
Widget recipeCard() {
  return Container(
    width: 350,
    height: 490,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 350,
          height: 230,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/recipe_image.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 300,
            height: 200,
            decoration: const BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Poke Bowl',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(
                  //text in middle
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Perk up under the heat with a refreshing poke bowl that reminds you of a summer breeze. Perk up under the heat with a refreshing poke bowl that reminds you of a summer breeze. refreshing poke bowl that reminds you of a summer breeze.',
                    style: TextStyle(
                      //text in middle of card

                      fontSize: 14,
                    ),
                  ),
                ),
                //cooking time, difficulty, servings
                Padding(
                  //padding top
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.timer,
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
                            Icons.whatshot,
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
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

//next recipe button
Widget nextRecipeButton() {
  return Container(
    width: 350,
    height: 50,
    decoration: BoxDecoration(
      color: secondaryColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: TextButton(
      onPressed: () {},
      child: const Text(
        'Next Recipe',
        style: TextStyle(
          fontSize: 18,
          letterSpacing: 0.8,
          fontWeight: FontWeight.bold,
          color: backgroundColor,
        ),
      ),
    ),
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
