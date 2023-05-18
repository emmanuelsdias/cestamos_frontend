import 'package:flutter/material.dart';
// import '../widgets/cestamos_bar.dart';
// import '../helpers/http-requests/user.dart';
// import '../models/user.dart';
import '../models/recipe.dart';

// import 'package:cestamos/helpers/http-requests/item.dart';
// import 'package:cestamos/helpers/http-requests/user_list.dart';
// import 'package:cestamos/models/friendship.dart';
// import 'package:cestamos/models/user.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/item.dart';
// import '../models/shop_list.dart';

// import '../helpers/http-requests/shop_list.dart';
// import '../helpers/http-requests/item.dart';

// import '../widgets/item_create_dialog.dart';
// import '../widgets/item_edit_dialog.dart';
// import '../widgets/add_friend_to_shop_list_dialog.dart';
// import '../widgets/show_members_of_list_dialog.dart';
// import '../widgets/confirm_quit_shop_list_dialog.dart';
// import '../widgets/add_floating_button.dart';
import '../widgets/helpers/flight_shuttle_builder.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({Key? key}) : super(key: key);
  static const pageRouteName = "/recipe_detail";

  @override
  // ignore: library_private_types_in_public_api
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

String _getUserNameFromUserId(int id) {
  return "Nome do usuário";
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final _recipe = Recipe(
    id: 1,
    userId: 1,
    recipeName: "Receita Teste",
    description: "Uma receita testada e aprovada!",
    peopleServed: 10,
    // ingredients: json['ingredients'] ITEMS? LIST? STRING?
    instructions: const [],
    prepTime: 50,
    cookingTime: 15,
    restingTime: 5,
    isPublic: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          transitionOnUserGestures: true,
          tag: _recipe.id,
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
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
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
                                      _getUserNameFromUserId(_recipe.userId),
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
                const SizedBox(height: 20),
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
                                  Row(
                                    children: [
                                      const Text("Ingrediente 1"),
                                      Expanded(
                                        child: Container(
                                          height: 0,
                                        ),
                                      ),
                                      const Text("200 g"),
                                      const SizedBox(width: 10),
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: FittedBox(
                                          child: FloatingActionButton(
                                            onPressed: () => {},
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            child: const Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
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
                const SizedBox(height: 20),
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
                                children: const [
                                  Text(
                                    "1",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Primeiro passo da receita",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                  "Descrição longa e detalhada do primeiro passo da receita, perceba que as vezes acaba tendo mais de uma linha."),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
