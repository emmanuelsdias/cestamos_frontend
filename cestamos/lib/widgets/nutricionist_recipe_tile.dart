import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../helpers/http-requests/recipe.dart';
import '../helpers/http-requests/shop_list.dart';
import './helpers/flight_shuttle_builder.dart';
import '../pages/edit_recipe_page.dart';

class NutricionistRecipeTile extends StatelessWidget {
  const NutricionistRecipeTile({
    Key? key,
    required this.recipeSummary,
    required this.listId,
    required this.isInList,
  }) : super(key: key);
  final RecipeSummary recipeSummary;
  final bool isInList;
  final int listId;

  Future<bool> _removeRecipeFromList(int recipeId, int listId) async {
    var response = ShopListHttpRequestHelper.removeRecipeFromList(listId, recipeId);
    return response.then((value) {
      return value.success;
    });
  }

  Future<bool> _addRecipeToList(int listId, int recipeId) async {
    var response = ShopListHttpRequestHelper.addRecipeToList(listId, recipeId);
    return response.then((value) {
      return value.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: ListTile(
              title: Hero(
                transitionOnUserGestures: true,
                tag: "${recipeSummary.id.toString()} receita",
                flightShuttleBuilder: flightShuttleBuilder,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        recipeSummary.recipeName,
                        overflow: TextOverflow.clip,
                        softWrap: false,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        recipeSummary.description,
                        overflow: TextOverflow.clip,
                        maxLines: 2,
                        softWrap: false,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9476D),
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
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.front_hand,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                recipeSummary.prepTime,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                " preparo ",
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9476D),
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
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.local_fire_department,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                recipeSummary.cookingTime,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                " fogo ",
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE9476D),
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
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.timer_rounded,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                recipeSummary.restingTime,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                " descanso ",
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: <Widget>[
                  // Cartas pra preencher fundo do icone com branco
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      color: Colors.white, // Color
                    ),
                  ),
                  isInList
                      ? IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          constraints: const BoxConstraints(),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Deseja mesmo remover a receita "${recipeSummary.recipeName}" da lista?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Remover',
                                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                                  ),
                                  onPressed: () {
                                    _removeRecipeFromList(recipeSummary.id, listId);
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                    Navigator.of(context).pushReplacementNamed('/');
                                  },
                                ),
                                TextButton(
                                  child: const Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                          icon: Icon(
                            Icons.cancel,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        )
                      : IconButton(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          constraints: const BoxConstraints(),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text('Deseja mesmo adicionar a receita "${recipeSummary.recipeName}" à lista?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Adicionar',
                                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                                  ),
                                  onPressed: () {
                                    _addRecipeToList(listId, recipeSummary.id);
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                    Navigator.of(context).pushReplacementNamed('/');
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                          icon: Icon(
                            Icons.add_box,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
