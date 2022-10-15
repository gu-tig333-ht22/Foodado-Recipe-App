import 'package:flutter/material.dart';
import 'package:grupp_5/components/models/filter_model.dart';

class InfoView extends StatefulWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => _InfoViewState();
}

class _InfoViewState extends State<InfoView> {
  late Future<FilterRecipe> futureFilterRecipe;

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
