import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/filter_model.dart';
import 'package:grupp_5/constants/constants.dart';
import '/constants/routes.dart';

class FilterView extends StatefulWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  double _value2 = 0;
  double _startvalue = 0;
  double _endvalue = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {},
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
        ));
  }

  Widget recipeTypeFilter() {
    List<String> recipeType = [
      'Breakfast',
      'Lunch',
      'Dinner',
      'Dessert',
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < recipeType.length; i++)
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
            ),
            onPressed: () {},
            child: Text(
              recipeType[i],
              style: const TextStyle(color: secondaryColor),
            ),
          ),
      ],
    );
  }

//searchbar for including specific ingredients, rounded corners

  Widget searchIncludeIngredients() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
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
    List<String> dietaryRestrictions = [
      'Vegan',
      'Vegetarian',
      'Gluten Free',
      'Dairy Free',
      'Nut Free',
      'Egg Free',
      'Soy Free',
      'Fish Free',
    ];
    return Wrap(
      children: [
        for (int i = 0; i < dietaryRestrictions.length; i++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(dietaryRestrictions[i]),
                Checkbox(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  value: false,
                  onChanged: (bool? value) {},
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget caloriesFilter() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Calories per serving',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        RangeSlider(
          activeColor: secondaryColor,
          values: RangeValues(_startvalue, _endvalue),
          min: 0,
          max: 700,
          divisions: 5,
          labels: RangeLabels(
            _startvalue.round().toString(),
            _endvalue.round().toString(),
          ),
          onChanged: (values) {
            setState(() {
              _startvalue = values.start;
              _endvalue = values.end;
            });
          },
        ),
      ],
    );
  }

//slider for prep time default 0-60 min
  Widget prepTimeFilter() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Prep Time'),
        ),
        Slider(
          activeColor: secondaryColor,
          value: _value2,
          min: 0,
          max: 240,
          divisions: 8,
          label: _value2.round().toString(),
          onChanged: (double value) {
            setState(() {
              _value2 = value;
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
    return Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(scrambleViewRoute);
        },
        child: const Text(
          'Apply',
          style: TextStyle(
            fontSize: 14,
            letterSpacing: 0.8,
            color: backgroundColor,
          ),
        ),
      ),
    );
  }
}
