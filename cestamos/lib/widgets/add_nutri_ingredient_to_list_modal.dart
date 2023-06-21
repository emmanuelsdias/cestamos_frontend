import 'package:cestamos/models/shop_list.dart';
import 'package:flutter/material.dart';

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

class AddNutriIngredientsToShopListModal extends StatefulWidget {
  final List<IngredientSelect> ingredients;
  final shopListId;

  AddNutriIngredientsToShopListModal({
    required List<Ingredient> ingredients,
    required this.shopListId,
    super.key,
  }) : ingredients = ingredients.map((i) => IngredientSelect.fromIngredient(i)).toList();

  @override
  State<AddNutriIngredientsToShopListModal> createState() => _AddNutriIngredientsToShopListModalState();
}

class _AddNutriIngredientsToShopListModalState extends State<AddNutriIngredientsToShopListModal> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Escolha os ingredientes"),
      content: SizedBox(
        height: 300,
        width: 250,
        child: _selectIngredients(context),
      ),
    );
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
                List<Item> items = widget.ingredients
                    .where((element) => element.selected)
                    .map((e) => Item(
                          name: e.name,
                          quantity: e.quantity,
                        ))
                    .toList();
                ShopListHttpRequestHelper.addItemsToList(widget.shopListId, items).then(
                  (value) {
                    if (value.success) {
                      Navigator.of(context).pop();
                    }
                  },
                );
              },
              child: const Text("Adicionar"),
            ),
          ],
        ),
      ],
    );
  }
}
