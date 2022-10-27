import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/filter_model.dart';
import 'package:grupp_5/constants/constants.dart';
import 'package:provider/provider.dart';
import '../../components/providers/provider.dart';
import '/constants/routes.dart';
import 'package:grupp_5/components/db/preferences_service.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  final _preferencesService = PreferencesService();
  final TextEditingController _controller = TextEditingController();
  double maxReadyTime = 15;
  double minCalories = 0;
  double maxCalories = 800;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    delay();
    _populateFilter();
  }

  Future delay() async {
    setState(() => isLoading = true);
    await Provider.of<RecipeProvider>(context, listen: false).fetchRecipe();
    setState(() => isLoading = false);
  }

  void _saveSettings() {
    final newSettings = FilterSettings(
        maxCal: maxCalories, minCal: minCalories, maxReadyTime: maxReadyTime);

    _preferencesService.saveSettings(newSettings);
  }

  void _populateFilter() async {
    final filterSettings = await _preferencesService.getSettings();
    setState(() {
      maxCalories = filterSettings.maxCal;
      minCalories = filterSettings.minCal;
      maxReadyTime = filterSettings.maxReadyTime;
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
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: isLoading
            ? loadingAnimation
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    recipeTypeFilter(),
                    searchIncludeIngredients(),
                    dietaryRestrictionsFilter(),
                    caloriesFilter(),
                    prepTimeFilter(),
                    applyButton(),
                  ],
                ),
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
    );
  }

  Widget dietaryRestrictionsFilter() {
    List<String> diet = [
      'Vegetarian',
      'Ketogenic',
      'Gluten Free',
      'Lacto-Vegetarian',
      'Ovo-Vegetarian',
      'Pescetarian'
          'Paleo',
      'Whole30'
    ];
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
        return ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                clipBehavior: Clip.antiAlias,
                children: [
                  for (var i = 0; i < diet.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          recipe.setDiet(diet[i]);
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          foregroundColor: recipe.diet == diet[i]
                              ? Colors.white
                              : Colors.black,
                          backgroundColor: recipe.diet == diet[i]
                              ? secondaryColor
                              : Colors.grey[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: Text(diet[i]),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget caloriesFilter() {
    return Consumer<RecipeProvider>(
      builder: (context, recipe, child) {
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
                if (minCalories + maxCalories < 200) {
                  setState(() {
                    minCalories = values.start;
                    maxCalories = values.end + 100;
                  });
                } else if (maxCalories - minCalories <= 100) {
                  setState(() {
                    minCalories = values.start - 100;
                    maxCalories = values.end;
                  });
                } else {
                  setState(() {
                    minCalories = values.start;
                    maxCalories = values.end;
                  });
                }
              },
            ),
          ],
        );
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
          max: 150,
          divisions: 9,
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
        return SizedBox(
          width: 200,
          height: 40,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
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
              recipe.setDiet(recipe.diet);
              recipe.fetchRecipe();
              Navigator.of(context).pushNamed(scrambleViewRoute);
              _saveSettings();
            },
            child: const Text(
              'Apply Filter',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
