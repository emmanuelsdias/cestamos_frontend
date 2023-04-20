import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';
import '../helpers/http-requests/recipe.dart';
import '../models/recipe.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);
  static const pageRouteName = "/recipe_detail";

  @override
  // ignore: library_private_types_in_public_api
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {

  Recipe _recipe = Recipe();
  var _loaded = false;

  void refreshRecipe() {
    setState(() {
      _loaded = false;
    });
  }

  Future<bool> _getRecipe(int recipeId) async {
    if (!_loaded) {
      _loaded = true;

      var response = RecipeHttpRequestHelper.getRecipe(recipeId);
      return response.then((value) {
        _recipe = value.content;
        return value.success;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final recipeSummary =
        ModalRoute.of(context)!.settings.arguments as RecipeSummary;
    return Scaffold(
      appBar: const CestamosBar(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<bool>(
        future: _getRecipe(recipeSummary.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var success = snapshot.data!;
          if (!success) {
            return const Center(
              child: Text(
                "Algo de errado aconteceu. Tente novamente mais tarde",
              ),
            );
          }
          return Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _recipe.recipeName,
                  ),
                  Text(
                    _recipe.description,
                  ),
                  Text(
                    "Ingredientes:${_recipe.ingredients}",
                  ),
                  Text(
                    "Instruções:${_recipe.instructions}",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
