import 'package:cestamos/models/friendship.dart';
import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/shop_list.dart';

import '../helpers/http-requests/shop_list.dart';

import '../widgets/item_create_dialog.dart';
import '../widgets/item_edit_dialog.dart';
import '../widgets/add_friend_to_shop_list_dialog.dart';
import '../widgets/confirm_quit_shop_list_dialog.dart';
import '../widgets/add_floating_button.dart';
import '../widgets/helpers/flight_shuttle_builder.dart';

class OneListPage extends StatefulWidget {
  const OneListPage({Key? key}) : super(key: key);
  static const pageRouteName = "/one_list";

  @override
  // ignore: library_private_types_in_public_api
  _OneListPageState createState() => _OneListPageState();
}

class _OneListPageState extends State<OneListPage> {
  List<Item> _items = [];
  var _loaded = false;

  void refreshList() {
    setState(() {
      _loaded = false;
    });
  }

  Future<bool> _getList(int shopListId) async {
    if (!_loaded) {
      _loaded = true;
      var response = ShopListHttpRequestHelper.getList(shopListId);
      return response.then((value) {
        _items = value.content.items;
        return value.success;
      });
    }
    return true;
  }

  void quitList() {
    // quit
  }

  void removeItem(int index) {
    // remove item
    setState(() {
      _items.removeAt(index);
    });
  }

  void addFriend(Friendship friendship) {
    // add friendship
  }

  void editItem(formKey, int itemId, String itemName, String itemQuantity) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (itemName.isNotEmpty & itemQuantity.isNotEmpty) {
      // editar item
      Navigator.of(context).pop();
    }
  }

  void createItem(formKey, String itemName, String itemQuantity) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (itemName.isNotEmpty & itemQuantity.isNotEmpty) {
      // criar item
      Navigator.of(context).pop();
    }
  }

  void changeBoughtStatus() {
    // change was_bought
  }

  String getListName() {
    // return list name
    return "Lista específica 1";
  }

  @override
  Widget build(BuildContext context) {
    final shopListSummary =
        ModalRoute.of(context)!.settings.arguments as ShopListSummary;
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
      floatingActionButton: AddFloatingButton(
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

  List<Widget> _getListItems() => _items
      .asMap()
      .map((i, item) => MapEntry(i, _buildTenableListTile(item, i)))
      .values
      .toList();

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
                  content: Text(
                      "Tem certeza que você quer excluir da sua lista o item ${_items[index].name}?"),
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
                        // TODO: Delete the item from DB etc..
                        setState(() {
                          _items.removeAt(index);
                        });
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
            setState(() {
              item.wasBought = value!;
            });
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
            decoration: item.wasBought
                ? TextDecoration.lineThrough
                : TextDecoration.none,
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
            decoration: item.wasBought
                ? TextDecoration.lineThrough
                : TextDecoration.none,
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
