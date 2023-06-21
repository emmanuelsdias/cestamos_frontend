import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './create_recipe_page.dart';
import './recipe_detail_page.dart';

import '../models/recipe.dart';
import '../models/shop_list.dart';
import '../models/user.dart';

import '../helpers/http-requests/shop_list.dart';
import '../widgets/cestamos_bar.dart';
import '../widgets/nutricionist_recipe_tile.dart';
import '../widgets/add_floating_button.dart';
import '../widgets/confirm_quit_shop_list_dialog.dart';
import '../widgets/helpers/flight_shuttle_builder.dart';

import '../helpers/http-requests/recipe.dart';
import '../helpers/http-requests/user_list.dart';

class NutriAddRecipeToListPage extends StatefulWidget {
  const NutriAddRecipeToListPage({super.key});
  static const pageRouteName = "/recipes";
  @override
  State<NutriAddRecipeToListPage> createState() => _NutriAddRecipeToListPageState();
}

class _NutriAddRecipeToListPageState extends State<NutriAddRecipeToListPage> {
  ShopList _shopList = ShopList();
  var _loaded = false;
  var _shopListId = 0;
  var _myUserId = 0;

  List<RecipeSummary> _recipes = [];
  List<RecipeSummary> _recipesInList = [];
  List<RecipeSummary> _recipesNotInList = [];

  void refreshPage() {
    setState(() {
      _loaded = false;
    });
  }

  Future<bool> _getList(int shopListId) async {
    if (!_loaded) {
      _loaded = true;

      if (_myUserId == 0) {
        var pref = SharedPreferences.getInstance();
        pref.then((value) {
          _myUserId = value.getInt('user_id') ?? 0;
        });
      }

      var response = ShopListHttpRequestHelper.getList(shopListId);
      return response.then((value) {
        _shopList = value.content;
        return value.success;
      });
    }
    return true;
  }

  Future<bool> _getAllMyRecipes() async {
    var response = RecipeHttpRequestHelper.getRecipes(false);
    return response.then((value) {
      _recipes = value.content;
      return value.success;
    });
  }

  Future<bool> _getRecipesInList() async {
    var response = ShopListHttpRequestHelper.getRecipesFromList(_shopListId);
    return response.then((value) {
      _recipesInList = value.content;
      return value.success;
    });
  }

  void _getRecipesNotInList() {
    var idsInList = _recipesInList.map((element) => element.id).toList();
    _recipesNotInList = _recipes.where((element) => !idsInList.contains(element.id)).toList();
  }

  Future<bool> _getRecipes() async {
    return _getAllMyRecipes().then(
      (value) {
        if (!value) {
          return false;
        }
        return _getRecipesInList().then(
          (otherValue) {
            if (!otherValue) {
              return false;
            }
            _getRecipesNotInList();
            return true;
          },
        );
      },
    );
  }

  void removeUserFromList(int userListId) {
    UserListHttpRequestHelper.deleteUserList(userListId);
  }

  UserList getUserListFromUserId(int userId) {
    return _shopList.users.firstWhere(
      (element) => element.id == userId,
    );
  }

  int getUserListIdFromUserId(int userId) {
    return getUserListFromUserId(userId).userListId;
  }

  void quitList() async {
    var pref = SharedPreferences.getInstance();
    pref.then((value) {
      var selfUserId = value.getInt('user_id') ?? 0;
      removeUserFromList(getUserListIdFromUserId(selfUserId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final shopListSummary = ModalRoute.of(context)!.settings.arguments as ShopListSummary;
    _shopListId = shopListSummary.id;
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          transitionOnUserGestures: true,
          tag: _shopListId,
          flightShuttleBuilder: flightShuttleBuilder,
          child: Text(
            shopListSummary.shopListName,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: _getRecipes,
            icon: const Icon(Icons.refresh_rounded),
          ),
          PopupMenuButton(
            onSelected: (result) {
              switch (result) {
                case 0:
                  {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return ConfirmQuitShopListDialog(
                          quit: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            quitList();
                          },
                        );
                      },
                    );
                  }
                  break;
                default:
                  break;
              }
            },
            icon: const Icon(Icons.more_vert_outlined),
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 0,
                child: Text('Sair do grupo'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<bool>(
          future: _getRecipes(),
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
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Receitas já na Lista",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                RecipeDetailPage.pageRouteName,
                                arguments: _recipesInList[index],
                              ),
                              child: NutricionistRecipeTile(
                                recipeSummary: _recipesInList[index],
                                isInList: true,
                                listId: _shopListId,
                              ),
                            );
                          },
                          itemCount: _recipesInList.length,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Receitas não adicionadas",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                RecipeDetailPage.pageRouteName,
                                arguments: _recipesNotInList[index],
                              ),
                              child: NutricionistRecipeTile(
                                recipeSummary: _recipesNotInList[index],
                                isInList: false,
                                listId: _shopListId,
                              ),
                            );
                          },
                          itemCount: _recipesNotInList.length,
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                      ],
                    ),
                  );
          }),
      floatingActionButton: AddFloatingButton(
        onPressed: () => Navigator.of(context).pushNamed(CreateRecipePage.pageRouteName),
      ),
    );
  }
}
