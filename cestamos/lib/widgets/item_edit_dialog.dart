import 'package:flutter/material.dart';

import '../models/item.dart';

class ItemEditDialog extends StatefulWidget {
  const ItemEditDialog({
    required this.editItem,
    required this.item,
    Key? key,
  }) : super(key: key);

  final Function editItem;
  final Item item;

  @override
  State<ItemEditDialog> createState() => _ItemEditDialogState();
}

class _ItemEditDialogState extends State<ItemEditDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String itemName = widget.item.name;
    String itemQuantity = widget.item.quantity;

    return Dialog(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Edite seu item",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: "Nome do item",
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    initialValue: widget.item.name,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Dê um nome ao seu item!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    onChanged: (newItemName) {
                      if (newItemName.isNotEmpty) {
                        setState(() {
                          itemName = newItemName;
                        });
                      }
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: "Quantidade do item",
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    initialValue: widget.item.quantity,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Dê uma quantidade ao seu item!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    onChanged: (newItemQuantity) {
                      if (newItemQuantity.isNotEmpty) {
                        setState(() {
                          itemQuantity = newItemQuantity;
                        });
                      }
                    },
                    textInputAction: TextInputAction.done,
                  ),
                  ElevatedButton(
                    onPressed: () => widget.editItem(
                      itemName,
                      itemQuantity,
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 56),
                        maximumSize: const Size(200, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.transparent,
                        primary: Theme.of(context).colorScheme.inversePrimary),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Finalizar edição',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.edit,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
