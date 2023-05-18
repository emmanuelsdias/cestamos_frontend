import 'package:flutter/material.dart';

import '../models/recipe.dart';

import '../widgets/cestamos_bar.dart';
import '../widgets/form_buton.dart';

import '../widgets/item_create_dialog.dart';
import '../widgets/section_create_dialog.dart';
// import '../widgets/item_edit_dialog.dart';
import '../widgets/add_floating_button.dart';

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({Key? key}) : super(key: key);

  static const pageRouteName = "/create_recipe";

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _recipeName = "";
  List<Ingredient> _ingredients = [];
  String _description = "";
  int _peopleServed = -1;
  List<Instruction> _instructions = [];
  int _prepTime = -1;
  int _cookingTime = -1;
  int _restingTime = -1;
  bool _isPublic = false;

  void _createRecipe() {}

  void _createItem(String itemName, String itemQuantity) {
    setState(() {
      _ingredients.add(
        Ingredient(
          ingredientName: itemName,
          ingredientQuantity: itemQuantity,
        ),
      );
    });
  }

  void _removeItem(String itemName, String itemQuantity) {
    setState(() {
      _ingredients.removeWhere((e) =>
          (e.ingredientName == itemName) &&
          (e.ingredientQuantity == itemQuantity));
    });
  }

  void _createSection(String sectionTitle, String sectionDescription) {
    setState(() {
      _instructions.add(
        Instruction(
          instructionTitle: sectionTitle,
          instructionDescription: sectionDescription,
        ),
      );
    });
  }

  void _removeSection(String sectionTitle, String sectionDescription) {
    setState(() {
      _instructions.removeWhere((e) =>
          (e.instructionTitle == sectionTitle) &&
          (e.instructionDescription == sectionDescription));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CestamosBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Criar nova receita",
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
                                  TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      label: const Text(
                                        "Título da receita",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      hintText:
                                          "Coloque um título para sua receita aqui",
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Dê um nome à sua receita!";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    onChanged: (recipeName) {
                                      if (recipeName.isNotEmpty) {
                                        _recipeName = recipeName;
                                      }
                                    },
                                    textInputAction: TextInputAction.done,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    minLines: 4,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.done,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        borderSide: const BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      label: const Text(
                                        "Descrição da receita",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      hintText: "Descreva sua receita aqui",
                                      filled: true,
                                      fillColor: Colors.grey[100],
                                    ),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Não esqueça de descrever a sua receita!";
                                      }
                                      return null;
                                    },
                                    onChanged: (description) {
                                      if (description.isNotEmpty) {
                                        _description = description;
                                      }
                                    },
                                  ),
                                  // Row(
                                  //   children: [
                                  //     const Text("Número de pessoas servidas:"),
                                  //     const SizedBox(
                                  //       width: 10,
                                  //     ),
                                  //     TextFormField(
                                  //       decoration: InputDecoration(
                                  //         border: OutlineInputBorder(
                                  //           borderRadius:
                                  //               BorderRadius.circular(30.0),
                                  //           borderSide: const BorderSide(
                                  //             width: 0,
                                  //             style: BorderStyle.none,
                                  //           ),
                                  //         ),
                                  //         filled: true,
                                  //         fillColor: Colors.grey[100],
                                  //       ),
                                  //       validator: (String? value) {
                                  //         if (value == null || value.isEmpty) {
                                  //           return "Insira um número!";
                                  //         }
                                  //         return null;
                                  //       },
                                  //       keyboardType: TextInputType.number,
                                  //       textInputAction: TextInputAction.done,
                                  //       // onChanged: (peopleServed) {
                                  //       //   if (peopleServed.isNotEmpty) {
                                  //       //     _peopleServed = peopleServed;
                                  //       //   }
                                  //       // },
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "Ingredientes da receita",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  for (var item in _ingredients)
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                item.ingredientName,
                                                // overflow: TextOverflow.clip, // not working
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  item.ingredientQuantity,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: FittedBox(
                                                    child: FloatingActionButton(
                                                      onPressed: () =>
                                                          _removeItem(
                                                        item.ingredientName,
                                                        item.ingredientQuantity,
                                                      ),
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  FloatingActionButton.extended(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return ItemCreateDialog(
                                            createItem: _createItem,
                                          );
                                        },
                                      );
                                    },
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                    label: Row(
                                      children: [
                                        Text(
                                          'Novo ingrediente',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.add,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (var i = 1; i <= _instructions.length; i++)
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "$i",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              _instructions[i - 1]
                                                  .instructionTitle,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () => _removeSection(
                                            _instructions[i - 1]
                                                .instructionTitle,
                                            _instructions[i - 1]
                                                .instructionDescription,
                                          ),
                                          icon: Icon(
                                            Icons.cancel,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      _instructions[i - 1]
                                          .instructionDescription,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return SectionCreateDialog(
                              createSection: _createSection,
                            );
                          },
                        );
                      },
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      label: Row(
                        children: [
                          Text(
                            'Adicionar seção',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.add,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Tornar receita privada?",
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Switch(
                    activeTrackColor: Theme.of(context).colorScheme.primary,
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _isPublic,
                    onChanged: (value) {
                      setState(() {
                        _isPublic = value;
                      });
                    },
                  ),
                ],
              ),
              FormButton(
                text: "Criar",
                icon: Icons.add,
                onPressed: () {
                  _createRecipe();
                  Navigator.of(context).pop();
                },
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
