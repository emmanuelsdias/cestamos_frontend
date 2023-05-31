import 'package:cestamos/models/shop_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/recipe.dart';
import '../models/item.dart';
import '../helpers/http-requests/shop_list.dart';

class IngredientSelect {
  String name;
  String quantity;
  bool selected;

  IngredientSelect({
    required this.name,
    required this.quantity,
    required this.selected,
  });

  factory IngredientSelect.fromIngredient(Ingredient ingredient) {
    return IngredientSelect(
      name: ingredient.ingredientName,
      quantity: ingredient.ingredientQuantity,
      selected: true,
    );
  }
}

enum ItemStage {
  selectIngredients,
  selectList,
}

class AddIngredientsToShopListModal extends StatefulWidget {
  final List<IngredientSelect> ingredients;

  AddIngredientsToShopListModal({
    required List<Ingredient> ingredients,
    super.key,
  }) : ingredients = ingredients.map((i) => IngredientSelect.fromIngredient(i)).toList();

  @override
  State<AddIngredientsToShopListModal> createState() => _AddIngredientsToShopListModalState();
}

class _AddIngredientsToShopListModalState extends State<AddIngredientsToShopListModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Escolha os ingredientes"),
      content: SizedBox(
        height: 300,
        width: 250,
        child: _content(context),
      ),
    );
  }

  ItemStage _itemStage = ItemStage.selectIngredients;
  List<ShopListSummary> _lists = [];
  bool _loadedLists = false;
  ShopListSummary? _selectedList = null;

  Future<bool> _getLists() async {
    if (_loadedLists) {
      return true;
    }
    var response = ShopListHttpRequestHelper.getLists();
    return response.then((value) {
      _lists = value.content;
      _loadedLists = true;
      return value.success;
    });
  }

  Widget _content(BuildContext context) {
    if (_itemStage == ItemStage.selectIngredients) {
      return _selectIngredients(context);
    } else if (_itemStage == ItemStage.selectList) {
      return _selectList(context);
    } else {
      return const Placeholder();
    }
  }

  Widget _selectIngredients(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.ingredients.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                title: Text(widget.ingredients[index].name),
                value: widget.ingredients[index].selected,
                onChanged: (bool? value) {
                  setState(() {
                    widget.ingredients[index].selected = value!;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _itemStage = ItemStage.selectList;
                });
              },
              child: const Text("Próximo"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _selectList(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getLists(),
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
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _lists.length,
                itemBuilder: (context, index) {
                  return RadioListTile<ShopListSummary>(
                    title: Text(_lists[index].shopListName),
                    value: _lists[index],
                    groupValue: _selectedList,
                    onChanged: (value) {
                      setState(() {
                        _selectedList = value;
                      });
                    },
                    activeColor: Theme.of(context).primaryColor,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text("Voltar"),
                  onPressed: () {
                    setState(() {
                      _itemStage = ItemStage.selectIngredients;
                    });
                  },
                ),
                TextButton(
                  child: const Text("Adicionar"),
                  onPressed: () {
                    List<Item> items = widget.ingredients
                        .where((element) => element.selected)
                        .map((e) => Item(
                              name: e.name,
                              quantity: e.quantity,
                            ))
                        .toList();
                    ShopListHttpRequestHelper.addItemsToList(_selectedList!.id, items).then(
                      (value) {
                        if (value.success) {
                          Navigator.of(context).pop();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
