import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/filter_model.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:provider/provider.dart';
import '../components/providers/provider.dart';
import '/constants/routes.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  final TextEditingController _controller = TextEditingController();
  double maxReadyTime = 15;
  double minCalories = 0;
  double maxCalories = 800;

  List<dynamic> dietaryRestrictions = [
    ['Vegan', false],
    ['Vegetarian', false],
    ['Gluten Free', false],
    ['Dairy Free', false],
    ['Nut Free', false],
    ['Egg Free', false],
    ['Soy Free', false],
    ['Fish Free', false],
  ];

  checkboxChanged(bool? value, int index) {
    setState(() {
      dietaryRestrictions[index][1] = !dietaryRestrictions[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Filter',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          //reset filter button
          IconButton(
            icon: const Icon(
              Icons.refresh_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Provider.of<RecipeProvider>(context, listen: false)
                  .clearFilters();
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            recipeTypeFilter(),
            searchIncludeIngredients(),
            dietaryRestrictionsFilter(),
            caloriesFilter(),
            prepTimeFilter(),
            costFilter(),
            applyButton(),
          ],
        ),
      ),
    );
  }

  Widget recipeTypeFilter() {
    List<String> recipeType = [
      'Breakfast',
      'Lunch',
      'Dinner',
      'Dessert',
      'Snack',
      'Drink'
    ];
    return Consumer<RecipeProvider>(builder: (context, recipe, child) {
      if (recipe.filterRecipe != null) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: recipeType.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        recipe.setRecipeType(recipeType[index]);
                      },
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        foregroundColor: recipe.type == recipeType[index]
                            ? Colors.white
                            : Colors.black,
                        backgroundColor: recipe.type == recipeType[index]
                            ? secondaryColor
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: secondaryColor),
                        ),
                      ),
                      child: Text(recipeType[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  Widget searchIncludeIngredients() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: 'Search for ingredients to include',
          prefixIcon: const Icon(Icons.search),
        ),
      ),
      //tags for ingredients
    );
  }

  Widget dietaryRestrictionsFilter() {
    return Wrap(
      children: [
        for (int i = 0; i < dietaryRestrictions.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(dietaryRestrictions[i][0]),
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  value: dietaryRestrictions[i][1],
                  onChanged: (value) => checkboxChanged(value, i),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget caloriesFilter() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe != null) {
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Calories per serving',
                ),
              ),
              RangeSlider(
                activeColor: secondaryColor,
                values: RangeValues(minCalories, maxCalories),
                min: 0,
                max: 800,
                divisions: 8,
                labels: RangeLabels(
                  '${minCalories.round()}kcal',
                  '${maxCalories.round()}kcal',
                ),
                onChanged: (values) {
                  setState(() {
                    minCalories = values.start;
                    maxCalories = values.end;
                  });
                },
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget prepTimeFilter() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Max cooking Time',
          ),
        ),
        Slider(
          activeColor: secondaryColor,
          value: maxReadyTime,
          min: 15,
          max: 160,
          divisions: 16,
          label: '${maxReadyTime.round()} min',
          onChanged: (double value) {
            setState(() {
              maxReadyTime = value;
            });
          },
        ),
      ],
    );
  }

  Widget costFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black),
              ),
            ),
          ),
          onPressed: () {
            //change color when clicked
          },
          child: const Text(
            '\$',
            style: TextStyle(color: secondaryColor),
          ),
        ),
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black),
              ),
            ),
          ),
          onPressed: () {
            //change color when clicked
          },
          child: const Text(
            '\$\$',
            style: TextStyle(color: secondaryColor),
          ),
        ),
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.black),
              ),
            ),
          ),
          onPressed: () {
            //change color when clicked
          },
          child: const Text(
            '\$\$\$',
            style: TextStyle(color: secondaryColor),
          ),
        ),
      ],
    );
  }

  Widget applyButton() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        if (recipe.filterRecipe != null) {
          return SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(secondaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {
                recipe.minCalories = minCalories.round().toString();
                recipe.maxCalories = maxCalories.round().toString();
                recipe.maxReadyTime = maxReadyTime.round().toString();
                recipe.setRecipeQuery(_controller.text);
                recipe.fetchRecipe();
                Navigator.of(context).pushNamed(scrambleViewRoute);
              },
              child: const Text(
                'Apply Filter',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
