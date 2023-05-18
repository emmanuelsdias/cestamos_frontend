import 'package:flutter/material.dart';

import './create_recipe_page.dart';
import './recipe_detail_page.dart';

import '../models/recipe.dart';

import '../widgets/cestamos_bar.dart';
import '../widgets/recipe_tile.dart';
import '../widgets/add_floating_button.dart';

// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});
  static const pageRouteName = "/recipes";

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  final List<RecipeSummary> _recipes = [
    RecipeSummary(
      id: 1,
      recipeName: "Receita Teste",
      description: "Uma receita testada e aprovada!",
      prepTime: 50,
      cookingTime: 15,
      restingTime: 5,
    )
  ]; // TEM QUE CRIAR O MODEL DA RECEITA

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
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: const <Widget>[
      //       Text(
      //         'Minhas receitas aqui ficarão aqui!',
      //       ),
      //     ],
      //   ),
      // ),
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
                                // arguments: _recipes[index],
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
          }),
      floatingActionButton: AddFloatingButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(CreateRecipePage.pageRouteName),
      ),
    );
  }
}
