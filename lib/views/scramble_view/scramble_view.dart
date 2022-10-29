import 'package:flutter/material.dart';
import 'package:grupp_5/components/db/recipe_database.dart';
import 'package:grupp_5/components/models/recipe_db_model.dart';
import 'package:grupp_5/components/models/recipe_model.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:provider/provider.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:grupp_5/constants/routes.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class ScrambleView extends StatefulWidget {
  const ScrambleView({Key? key}) : super(key: key);

  @override
  State<ScrambleView> createState() => _ScrambleViewState();
}

class _ScrambleViewState extends State<ScrambleView> {
  bool isLoading = false;
  AppinioSwiperController swiperController = AppinioSwiperController();

  @override
  void initState() {
    super.initState();
    delay();
  }

  //future for loading
  Future delay() async {
    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<RecipeProvider>(context, listen: false).fetchRecipe();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

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
        actions: [
          IconButton(
            icon: const Icon(
              Icons.folder_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(saveViewRoute);
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.sort,
            color: Colors.black,
          ),
          onPressed: () {
            Provider.of<RecipeProvider>(context, listen: false).clearRecipes();
            Navigator.of(context).pushNamed(filterViewRoute);
          },
        ),
      ),
      body: isLoading ? Center(child: loadingAnimation) : buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            swipeCard(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: buttons(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardContainer(Recipe recipe) {
    return Container(
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
                image: NetworkImage(recipe.image),
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
                    recipe.title,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Html(
                    data: recipe.summary,
                    style: {
                      '#': Style(
                        textAlign: TextAlign.center,
                        fontSize: const FontSize(16),
                        maxLines: 6,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    },
                  ),
                  Padding(
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
                              '${recipe.readyInMinutes} min',
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
                              '${recipe.servings} servings',
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
    );
  }

  Widget swipeCard() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe == null || recipe.recipes.isEmpty) {
          return noRecipesFound();
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width * 0.9,
            child: AppinioSwiper(
              controller: swiperController,
              key: UniqueKey(),
              allowUnswipe: true,
              onSwipe: (int index, AppinioSwiperDirection direction) =>
                  recipe.nextRecipe(),
              cards: [
                for (var i = 0; i < recipe.recipes.length; i++)
                  GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                      recipeViewRoute,
                    ),
                    child: cardContainer(recipe.recipes[i]),
                  ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buttons() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe == null || recipe.recipes.isEmpty) {
          return Container();
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  swiperController.swipeLeft();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [shadow],
                  ),
                  child: const Icon(
                    Icons.clear_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
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
                      } else {
                        RecipeDatabase.instance.delete(
                          recipe.recipes.last.id,
                        );
                      }
                    },
                  );
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [shadow],
                  ),
                  child: recipe.recipes.last.isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget noRecipesFound() {
    return Column(
      children: [
        Container(
          width: 700,
          height: 400,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/empty.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 30.0),
          child: Text(
            //text center
            'No recipes found!\nPlease try again.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(filterViewRoute);
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
                'Go Back',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
