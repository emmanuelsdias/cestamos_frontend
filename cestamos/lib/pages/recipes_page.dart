import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import './create_recipe_page.dart';
import './recipe_detail_page.dart';

import '../models/recipe.dart';

import '../widgets/cestamos_bar.dart';
import '../widgets/recipe_tile.dart';
import '../widgets/add_floating_button.dart';

import '../helpers/http-requests/recipe.dart';
// import '../models/user.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});
  static const pageRouteName = "/recipes";
  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  bool isMyFeed = true;
  List<RecipeSummary> _recipes = [
    RecipeSummary(
      id: 1,
      recipeName: "Receita Teste",
      description: "Uma receita testada e aprovada!",
      prepTime: "50",
      cookingTime: "15",
      restingTime: "5",
    )
  ];

  Future<bool> _refreshRecipes() async {
    var response = RecipeHttpRequestHelper.getRecipes(!isMyFeed);
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
                child: Text("Algo de errado aconteceu nas suas receitas. Tente novamente mais tarde!"),
              );
            }

            return _recipes.isEmpty
                ? const Center(
                    child: Text("Você ainda não tem receitas!"),
                  )
                : Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: isMyFeed
                                ? const Text(
                                    "Minhas Receitas",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  )
                                : const Text(
                                    "Receitas de Amigos",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: FlutterSwitch(
                                value: !isMyFeed,
                                activeColor: Theme.of(context).colorScheme.primary,
                                inactiveIcon: const Icon(
                                  Icons.person_rounded,
                                  color: Colors.black,
                                ),
                                activeIcon: Icon(
                                  Icons.people_rounded,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                ),
                                onToggle: ((value) => setState(() => {isMyFeed = !isMyFeed}))),
                          )
                        ],
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
                                isMyFeed: isMyFeed,
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
        onPressed: () => Navigator.of(context).pushNamed(CreateRecipePage.pageRouteName),
      ),
    );
  }
}
