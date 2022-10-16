import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/filter_model.dart';
import 'package:grupp_5/components/models/filter_data.dart';
import 'package:grupp_5/components/providers/provider.dart';
import 'package:provider/provider.dart';

class InfoView extends StatefulWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  final TextEditingController _controller = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Info View',
        ),
      ),
      body: //listbuilder future
          Center(
        child: Consumer<RecipeProvider>(
          builder: (context, recipe, child) {
            return ListView.builder(
              //image and id
              itemCount: recipe.filterRecipe!.results.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.network(
                      recipe.filterRecipe!.results[index].image,
                    ),
                    Text(
                      recipe.filterRecipe!.results[index].id.toString(),
                    ),
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter a search term',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        type = 'appetizer';
                      },
                      child: const Text('Appetizer'),
                    ),
                    TextButton(
                      onPressed: () {
                        type = 'main course';
                      },
                      child: const Text('Main course'),
                    ),
                    TextButton(
                      onPressed: () {
                        type = 'dessert';
                      },
                      child: const Text('Dessert'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          query = _controller.text;
                          recipe.fetchFilterRecipe();
                        });
                      },
                      child: const Text('Execute'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
