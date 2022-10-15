import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/filter_model.dart';
import 'package:grupp_5/components/models/filter_data.dart';

class InfoView extends StatefulWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  late Future<FilterRecipe> futureFilterRecipe;
  //text controller
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureFilterRecipe = fetchFilterRecipe();
  }

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
        child: FutureBuilder<FilterRecipe>(
          future: futureFilterRecipe,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                //image and id
                itemCount: snapshot.data!.results.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Image.network(
                        snapshot.data!.results[index].image,
                      ),
                      Text(snapshot.data!.results[index].id.toString()),

                      //input to change query string and button to execute
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
                            futureFilterRecipe = fetchFilterRecipe();
                          });
                        },
                        child: const Text('Execute'),
                      ),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
