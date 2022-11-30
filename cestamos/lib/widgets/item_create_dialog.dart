import 'package:flutter/material.dart';

import '../widgets/form_buton.dart';

class ItemCreateDialog extends StatefulWidget {
  const ItemCreateDialog({
    required this.createItem,
    Key? key,
  }) : super(key: key);

  final Function createItem;

  @override
  State<ItemCreateDialog> createState() => _ItemCreateDialogState();
}

class _ItemCreateDialogState extends State<ItemCreateDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String itemName = "";
    String itemQuantity = "";

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
                "Adicione seu item",
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
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Dê um nome ao seu item!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        onChanged: (newItemName) {
                          if (newItemName.isNotEmpty) {
                            // setState(() {
                            itemName = newItemName;
                            // });
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
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Dê uma quantidade ao seu item!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        onChanged: (newItemQuantity) {
                          if (newItemQuantity.isNotEmpty) {
                            // setState(() {
                            itemQuantity = newItemQuantity;
                            // });
                          }
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      FormButton(
                        text: "Adicionar",
                        icon: Icons.add,
                        onPressed: () => widget.createItem(
                          _formKey,
                          itemName,
                          itemQuantity,
                        ),
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
