import 'package:flutter/material.dart';

import '../models/recipe.dart';

import '../widgets/cestamos_bar.dart';
import '../widgets/form_buton.dart';

import '../widgets/item_create_dialog.dart';
import '../widgets/section_create_dialog.dart';
import '../helpers/http-requests/recipe.dart';

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({Key? key}) : super(key: key);

  static const pageRouteName = "/create_recipe";

  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _recipeName = "";
  final List<Ingredient> _ingredients = [];
  String _description = "";
  final int _peopleServed = -1;
  final List<Instruction> _instructions = [];
  String _prepTime = "-1";
  String _cookingTime = "-1";
  String _restingTime = "-1";
  bool _isPublic = false;

  Future<bool> _createRecipe() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();

    var recipe = Recipe(
      recipeName: _recipeName,
      ingredients: _ingredients,
      description: _description,
      peopleServed: _peopleServed,
      instructions: _instructions,
      prepTime: _prepTime,
      cookingTime: _cookingTime,
      restingTime: _restingTime,
      isPublic: _isPublic,
    );

    var response = RecipeHttpRequestHelper.createRecipe(recipe);
    return response.then((value) {
      return value.success;
    });
  }

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
      _ingredients.removeWhere((e) => (e.ingredientName == itemName) && (e.ingredientQuantity == itemQuantity));
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
      _instructions.removeWhere((e) => (e.instructionTitle == sectionTitle) && (e.instructionDescription == sectionDescription));
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
                                        borderRadius: BorderRadius.circular(15.0),
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
                                      hintText: "Coloque um título para sua receita aqui",
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
                                        borderRadius: BorderRadius.circular(15.0),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Tempo de preparo:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                          ),
                                          validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                              return "Faltou o tempo de preparo!";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          onChanged: (prepTime) {
                                            if (prepTime.isNotEmpty) {
                                              _prepTime = prepTime;
                                            }
                                          },
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Tempo de fogo:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                          ),
                                          validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                              return "Faltou o tempo de fogo!";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          onChanged: (cookingTime) {
                                            if (cookingTime.isNotEmpty) {
                                              _cookingTime = cookingTime;
                                            }
                                          },
                                          textInputAction: TextInputAction.done,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Tempo de descanso:",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                              borderSide: const BorderSide(
                                                width: 0,
                                                style: BorderStyle.none,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                          ),
                                          validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                              return "Faltou o tempo de descanso!";
                                            }
                                            return null;
                                          },
                                          keyboardType: TextInputType.name,
                                          onChanged: (restingTime) {
                                            if (restingTime.isNotEmpty) {
                                              _restingTime = restingTime;
                                            }
                                          },
                                          textInputAction: TextInputAction.done,
                                        ),
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: FittedBox(
                                                    child: FloatingActionButton(
                                                      onPressed: () => _removeItem(
                                                        item.ingredientName,
                                                        item.ingredientQuantity,
                                                      ),
                                                      backgroundColor: Theme.of(context).colorScheme.primary,
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
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    label: Row(
                                      children: [
                                        Text(
                                          'Novo ingrediente',
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    for (var i = 0; i < _instructions.length; i++)
                      Column(
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "${i + 1}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 40,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  _instructions[i].instructionTitle,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () => _removeSection(
                                                _instructions[i].instructionTitle,
                                                _instructions[i].instructionDescription,
                                              ),
                                              icon: Icon(
                                                Icons.cancel,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          _instructions[i].instructionDescription,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
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
                            Icons.add_to_photos,
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
                    value: !_isPublic,
                    onChanged: (value) {
                      setState(() {
                        _isPublic = !value;
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
