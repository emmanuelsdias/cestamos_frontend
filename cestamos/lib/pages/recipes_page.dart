import 'package:flutter/material.dart';
import '../widgets/cestamos_bar.dart';
import '../models/recipe.dart';
import '../widgets/recipe_tile.dart';
import './recipe_detail_page.dart';

import '../helpers/http-requests/recipe.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});
  static const pageRouteName = "/recipes";

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List<RecipeSummary> _recipes = [];

  Future<bool> _refreshRecipes() async {
    var response = RecipeHttpRequestHelper.getUserRecipes();
    return response.then((value) {
      _recipes = value.content;
      return value.success;
    });
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
      body: FutureBuilder<bool>(
          future: _refreshRecipes(),
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
                    "Algo de errado aconteceu nas suas receitas. Tente novamente mais tarde!"),
              );
            }
            return _recipes.isEmpty
                ? const Center(
                    child: Text("Você ainda não tem receitas!"),
                  )
                : Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          "Minhas Receitas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                RecipeDetailPage.pageRouteName,
                                arguments: _recipes[index],
                              ),
                              child: RecipeTile(
                                recipeSummary: _recipes[index],
                              ),
                            );
                          },
                          itemCount: _recipes.length,
                        ),
                      ),
                    ],
                  );
            },
          ),
    );
  }
}
