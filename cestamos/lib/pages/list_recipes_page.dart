import 'package:flutter/material.dart';
import './nutri_recipe_detail_page.dart';

import '../models/recipe.dart';
import '../models/shop_list.dart';
import '../models/mega_model.dart';

import '../widgets/recipe_tile.dart';

import '../helpers/http-requests/shop_list.dart';

class ListRecipesPage extends StatefulWidget {
  const ListRecipesPage({super.key});
  static const pageRouteName = "/list-recipes";
  @override
  State<ListRecipesPage> createState() => _ListRecipesPageState();
}

class _ListRecipesPageState extends State<ListRecipesPage> {
  int _shopListId = -1;

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

  Future<bool> _refreshRecipes(int shopListId) async {
    var response = ShopListHttpRequestHelper.getRecipesFromList(shopListId);
    return response.then((value) {
      _recipes = value.content;

      return value.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    final shopListSummary = ModalRoute.of(context)!.settings.arguments as ShopListSummary;
    _shopListId = shopListSummary.id;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          shopListSummary.shopListName,
          overflow: TextOverflow.clip,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => _refreshRecipes(_shopListId),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<bool>(
        future: _refreshRecipes(_shopListId),
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
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Receitas da Lista",
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
                            onTap: () {
                              MegaModel mega = MegaModel(
                                shopListId: _shopListId,
                                recipeSummary: _recipes[index],
                              );
                              Navigator.pushNamed(
                                context,
                                NutriRecipeDetailPage.pageRouteName,
                                arguments: mega,
                              );
                            },
                            child: RecipeTile(
                              recipeSummary: _recipes[index],
                              isMyFeed: false,
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
