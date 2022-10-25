import 'package:flutter/material.dart';
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
      body: Center(
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
                        recipe.type = 'appetizer';
                      },
                      child: const Text('Appetizer'),
                    ),
                    TextButton(
                      onPressed: () {
                        recipe.type = 'main course';
                      },
                      child: const Text('Main course'),
                    ),
                    TextButton(
                      onPressed: () {
                        recipe.type = 'dessert';
                      },
                      child: const Text('Dessert'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          recipe.query = _controller.text;
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
