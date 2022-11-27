import 'package:flutter/material.dart';

import '../models/item.dart';
import '../widgets/form_buton.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Edite seu item",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "Nome do item",
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
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Quantidade do item",
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
                      Expanded(
                        child: Container(),
                      ),
                      FormButton(
                        text: "Alterar",
                        icon: Icons.edit,
                        onPressed: widget.editItem,
                        option: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormButton(
                        text: "Cancelar",
                        icon: Icons.cancel,
                        onPressed: () => Navigator.of(context).pop(),
                        option: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
