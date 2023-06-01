import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../helpers/http-requests/recipe.dart';
import './helpers/flight_shuttle_builder.dart';
import '../pages/edit_recipe_page.dart';

class RecipeTile extends StatelessWidget {
  const RecipeTile({Key? key, required this.recipeSummary, required this.isMyFeed}) : super(key: key);
  final RecipeSummary recipeSummary;
  final bool isMyFeed;

  Future<bool> _deleteRecipe(int recipeId) async {
    var response = RecipeHttpRequestHelper.deleteRecipe(recipeId);
    return response.then((value) {
      return value.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isMyFeed) {}
    return Padding(
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
                  Row(
                    mainAxisAlignment: isMyFeed ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                    children: [
                      if (isMyFeed) ...[
                        const SizedBox(
                          width: 65,
                        )
                      ],
                      Expanded(
                        child: Text(
                          textAlign: TextAlign.center,
                          recipeSummary.recipeName,
                          overflow: TextOverflow.clip,
                          softWrap: false,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      if (isMyFeed) ...[
                        Row(
                          children: [
                            IconButton(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              constraints: const BoxConstraints(),
                              onPressed: () => Navigator.pushNamed(
                                context,
                                EditRecipePage.pageRouteName,
                                arguments: recipeSummary,
                              ),
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            IconButton(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              constraints: const BoxConstraints(),
                              onPressed: () => showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text('Deseja mesmo deletar a receita "${recipeSummary.recipeName}"? Esta ação não poderá ser revertida!'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        'Deletar',
                                        style: TextStyle(color: Colors.redAccent),
                                      ),
                                      onPressed: () {
                                        _deleteRecipe(recipeSummary.id);
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
                            ),
                          ],
                        ),
                      ]
                    ],
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
    );
  }
}
