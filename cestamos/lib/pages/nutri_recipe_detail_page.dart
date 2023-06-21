import 'package:cestamos/helpers/http-requests/shop_list.dart';
import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../models/mega_model.dart';

import '../widgets/add_nutri_ingredient_to_list_modal.dart';
import '../widgets/helpers/flight_shuttle_builder.dart';

class NutriRecipeDetailPage extends StatefulWidget {
  const NutriRecipeDetailPage({Key? key}) : super(key: key);
  static const pageRouteName = "/recipe_detail_nutri";

  @override
  // ignore: library_private_types_in_public_api
  State<NutriRecipeDetailPage> createState() => _NutriRecipeDetailPageState();
}

class _NutriRecipeDetailPageState extends State<NutriRecipeDetailPage> {
  Recipe _recipe = Recipe();
  int _shopListId = -1;

  Future<bool> _refreshRecipe(int shopListId, int recipeId) async {
    var response = ShopListHttpRequestHelper.getRecipeFromList(shopListId, recipeId);
    return response.then((value) {
      _recipe = value.content;
      return value.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mega = ModalRoute.of(context)!.settings.arguments as MegaModel;
    final recipeSummary = mega.recipeSummary!;
    var recipeId = recipeSummary.id;
    _shopListId = mega.shopListId!;

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          transitionOnUserGestures: true,
          tag: "${_recipe.id.toString()} receita",
          flightShuttleBuilder: flightShuttleBuilder,
          child: Text(
            _recipe.recipeName,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _refreshRecipe(_shopListId, recipeId);
              });
            },
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<bool>(
        future: _refreshRecipe(_shopListId, recipeId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var success = snapshot.data!;
          if (!success) {
            return const Center(
              child: Text("Algo de errado aconteceu na receita. Tente novamente mais tarde!"),
            );
          }
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.account_circle_rounded,
                                          size: 50,
                                          color: Colors.black.withOpacity(0.3),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _recipe.authorUserName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _recipe.recipeName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    _recipe.description,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 1,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Ingredientes",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      for (var item in _recipe.ingredients)
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    item.ingredientName,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      item.ingredientQuantity,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      FloatingActionButton.extended(
                                        onPressed: () {
                                          // open modal
                                          showDialog(
                                            context: context,
                                            builder: (context) => AddNutriIngredientsToShopListModal(
                                              ingredients: _recipe.ingredients,
                                              shopListId: _shopListId,
                                            ),
                                          );
                                        },
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        label: Row(
                                          children: [
                                            Text(
                                              'Adicionar à lista',
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onPrimary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.add,
                                              color: Theme.of(context).colorScheme.onPrimary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (var i = 0; i < _recipe.instructions.length; i++)
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            Text(
                                              "${i + 1}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                _recipe.instructions[i].instructionTitle,
                                                // overflow: TextOverflow.clip,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _recipe.instructions[i].instructionDescription,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
