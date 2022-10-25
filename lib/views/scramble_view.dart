import 'package:flutter/material.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '/constants/routes.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class ScrambleView extends StatefulWidget {
  const ScrambleView({Key? key}) : super(key: key);

  @override
  State<ScrambleView> createState() => _ScrambleViewState();
}

class _ScrambleViewState extends State<ScrambleView> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    delay();
  }

  //future for loading
  Future delay() async {
    setState(() => isLoading = true);
    //await Future.delayed(const Duration(seconds: 1));
    await Provider.of<RecipeProvider>(context, listen: false).fetchRecipe();
    setState(() => isLoading = false);
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
            Navigator.of(context).pushNamed(filterViewRoute);
          },
        ),
      ),
      // bottomNavigationBar: bottomNavigationBar(),
      body: isLoading ? Center(child: loadingAnimation) : buildBody(),
    );
  }

  Widget buildBody() {
    return Center(
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
    );
  }

// write code that places the widget recipecard and the nextrecipe button on fixed positions on the screen

  Widget bodyContainer() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
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
                    image: NetworkImage(recipe.filterRecipe?.results[0].image ??
                        'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png'),
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
                        recipe.filterRecipe!.results[0].title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Html(
                        data: recipe.filterRecipe!.results[0].summary,
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
                                  '${recipe.filterRecipe!.results[0].readyInMinutes} min',
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
                                  '${recipe.filterRecipe!.results[0].servings} servings',
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
      },
    );
  }

  Widget recipeCard() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe == null ||
            recipe.filterRecipe!.results.isEmpty) {
          return noRecipesFound();
        } else {
          return GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(recipeViewRoute),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.9,
              child: AppinioSwiper(
                key: UniqueKey(),
                cards: [
                  for (var i = 0; i < recipe.filterRecipe!.results.length; i++)
                    bodyContainer(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

//
//next recipe button
  Widget nextRecipeButton() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe == null ||
            recipe.filterRecipe!.results.isEmpty) {
          return Container();
        } else {
          return GestureDetector(
            onTap: () {
              setState(() {
                recipe.fetchRecipe();
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
        }
      },
    );
  }

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
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
          child: const Text(
            //text center
            'No recipes found!' + '\n' + 'Please try again.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            //navigate to filter
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
