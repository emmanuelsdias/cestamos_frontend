import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';
// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});
  static const pageRouteName = "/recipes";

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  Future<bool> _refreshRecipes() async {
    // var response = ShopListHttpRequestHelper.getLists();
    // return response.then((value) {
    //   _lists = value.content;

    //   return value.success;
    // });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CestamosBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _refreshRecipes();
              });
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Minhas receitas aqui ficarão aqui!',
            ),
          ],
        ),
      ),
    );
  }
}
