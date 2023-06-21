import 'package:cestamos/helpers/http-requests/item.dart';
import 'package:cestamos/helpers/http-requests/user_list.dart';
import 'package:cestamos/models/friendship.dart';
import 'package:cestamos/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/item.dart';
import '../models/shop_list.dart';

import '../helpers/http-requests/shop_list.dart';

import '../widgets/item_create_dialog.dart';
import '../widgets/item_edit_dialog.dart';
import '../widgets/add_friend_to_shop_list_dialog.dart';
import '../widgets/add_nutricionist_to_shop_list_dialog.dart';
import '../widgets/show_members_of_list_dialog.dart';
import '../widgets/confirm_quit_shop_list_dialog.dart';
import '../widgets/add_floating_button.dart';
import '../widgets/helpers/flight_shuttle_builder.dart';

import './list_recipes_page.dart';

class ListDetailPage extends StatefulWidget {
  const ListDetailPage({Key? key}) : super(key: key);
  static const pageRouteName = "/list_detail";

  @override
  // ignore: library_private_types_in_public_api
  _ListDetailPageState createState() => _ListDetailPageState();
}

class _ListDetailPageState extends State<ListDetailPage> {
  List<Item> _items = [];
  ShopList _shopList = ShopList();
  var _loaded = false;
  var _shopListId = 0;
  var _myUserId = 0;

  void refreshList() {
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
        _items = value.content.items;
        return value.success;
      });
    }
    return true;
  }

  void removeUserFromList(int userListId) {
    UserListHttpRequestHelper.deleteUserList(userListId);
  }

  void changeUserStatus(int userListId, bool shouldBecomeAdm) {
    UserListHttpRequestHelper.changeUserStatus(userListId, shouldBecomeAdm);
  }

  int getUserListIdFromUserId(int userId) {
    return getUserListFromUserId(userId).userListId;
  }

  UserList getUserListFromUserId(int userId) {
    return _shopList.users.firstWhere(
      (element) => element.id == userId,
    );
  }

  void quitList() async {
    var pref = SharedPreferences.getInstance();
    pref.then((value) {
      var selfUserId = value.getInt('user_id') ?? 0;
      removeUserFromList(getUserListIdFromUserId(selfUserId));
    });
  }

  void removeItem(Item item) {
    ItemHttpRequestHelper.deleteItem(item);
    refreshList();
  }

  void addFriend(Friendship friendship, {bool isNutricionist = false}) async {
    await ShopListHttpRequestHelper.addFriendtoList(_shopList.id, friendship.userId, isNutricionist);
    refreshList();
  }

  void editItem(Item item) {
    ItemHttpRequestHelper.editItem(item);
    refreshList();
  }

  void createItem(String itemName, String itemQuantity) async {
    var newList = await ShopListHttpRequestHelper.addItemToList(
      _shopListId,
      itemName,
      itemQuantity,
    );
    setState(() {
      _items = newList.content.items;
    });
    refreshList();
  }

  @override
  Widget build(BuildContext context) {
    final shopListSummary = ModalRoute.of(context)!.settings.arguments as ShopListSummary;
    _shopListId = shopListSummary.id;
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          transitionOnUserGestures: true,
          tag: shopListSummary.id,
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
            onPressed: refreshList,
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
                        return AddFriendToShopListDialog(
                          addFriend: addFriend,
                        );
                      },
                    );
                  }
                  break;
                case 1:
                  {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AddNutricionistToShopListDialog(
                          addFriend: addFriend,
                        );
                      },
                    );
                  }
                  break;
                case 2:
                  {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return ShowMembersOfListDialog(
                          listMembers: _shopList.users,
                          selfUser: getUserListFromUserId(_myUserId),
                          expellUser: (int userListId) {
                            removeUserFromList(userListId);
                          },
                          changeUserStatus: (int userListId, bool shouldBecomeAdm) {
                            changeUserStatus(
                              userListId,
                              shouldBecomeAdm,
                            );
                            refreshList();
                          },
                        );
                      },
                    );
                  }
                  break;
                case 3:
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
                child: Text('Adicionar amigo'),
              ),
              const PopupMenuItem(
                value: 1,
                child: Text('Adicionar nutricionista'),
              ),
              const PopupMenuItem(
                value: 2,
                child: Text('Membros do grupo'),
              ),
              const PopupMenuItem(
                value: 3,
                child: Text('Sair do grupo'),
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder<bool>(
        future: _getList(shopListSummary.id),
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
          return ReorderableListView(
            onReorder: onReorder,
            buildDefaultDragHandles: false,
            children: _getListItems(),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: const Color(0xFF77DD77),
            onPressed: () {
              Navigator.of(context).pushNamed(
                ListRecipesPage.pageRouteName,
                arguments: shopListSummary,
              );
            },
            child: const Icon(
              Icons.liquor,
              color: Color.fromARGB(255, 70, 105, 70),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          AddFloatingButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return ItemCreateDialog(
                    createItem: createItem,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    setState(() {
      Item item = _items[oldIndex];

      _items.removeAt(oldIndex);
      _items.insert(newIndex, item);
    });
  }

  List<Widget> _getListItems() => _items.asMap().map((i, item) => MapEntry(i, _buildTenableListTile(item, i))).values.toList();

  Widget _buildTenableListTile(Item item, int index) {
    return Dismissible(
      key: ValueKey(item.itemId),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        setState(() {
          _items.removeAt(index);
        });
      },
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final bool res = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Tem certeza que você quer excluir da sua lista o item ${_items[index].name}?"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    TextButton(
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        removeItem(item);
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                );
              });
          return res;
        }
        return false;
      },
      background: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(Icons.delete),
      ),
      child: ListTile(
        leading: Checkbox(
          checkColor: Colors.white,
          activeColor: Theme.of(context).colorScheme.inversePrimary,
          value: item.wasBought,
          onChanged: (bool? value) {
            item.wasBought = value ?? item.wasBought;
            editItem(item);
          },
        ),
        trailing: ReorderableDragStartListener(
          index: index,
          child: const Icon(Icons.drag_indicator_outlined),
        ),
        key: ValueKey(item.itemId),
        title: Text(
          item.name,
          maxLines: 1,
          overflow: TextOverflow.clip,
          softWrap: false,
          style: TextStyle(
            decoration: item.wasBought ? TextDecoration.lineThrough : TextDecoration.none,
            decorationThickness: 2,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          item.quantity,
          maxLines: 1,
          overflow: TextOverflow.clip,
          softWrap: false,
          style: TextStyle(
            decoration: item.wasBought ? TextDecoration.lineThrough : TextDecoration.none,
            decorationThickness: 2,
            color: Colors.black,
          ),
        ),
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return ItemEditDialog(
                editItem: editItem,
                item: item,
              );
            },
          );
        },
      ),
    );
  }
}
