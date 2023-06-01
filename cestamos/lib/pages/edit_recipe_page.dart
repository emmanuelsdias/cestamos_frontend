import 'package:flutter/material.dart';

import '../models/recipe.dart';

import '../widgets/cestamos_bar.dart';
import '../widgets/form_buton.dart';

import '../helpers/http-requests/recipe.dart';
import '../widgets/item_create_dialog.dart';
import '../widgets/section_create_dialog.dart';

class EditRecipePage extends StatefulWidget {
  const EditRecipePage({Key? key}) : super(key: key);
  static const pageRouteName = "/edit_recipe";

  @override
  State<EditRecipePage> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends State<EditRecipePage> {
  Recipe _recipe = Recipe();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<bool> _refreshRecipe(int recipeId) async {
    var response = RecipeHttpRequestHelper.getRecipe(recipeId);
    return response.then((value) {
      _recipe = value.content;
      return value.success;
    });
  }

  Future<bool> _editRecipe() async {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();

    var recipe = _recipe;

    var response = RecipeHttpRequestHelper.editRecipe(recipe);

    return response.then((value) {
      return value.success;
    });
  }

  void _createItem(String itemName, String itemQuantity) {
    setState(() {
      _recipe.ingredients.add(
        Ingredient(
          ingredientName: itemName,
          ingredientQuantity: itemQuantity,
        ),
      );
    });
  }

  void _removeItem(String itemName, String itemQuantity) {
    setState(() {
      _recipe.ingredients.removeWhere((e) => (e.ingredientName == itemName) && (e.ingredientQuantity == itemQuantity));
    });
  }

  void _createSection(String sectionTitle, String sectionDescription) {
    setState(() {
      _recipe.instructions.add(
        Instruction(
          instructionTitle: sectionTitle,
          instructionDescription: sectionDescription,
        ),
      );
    });
  }

  void _removeSection(String sectionTitle, String sectionDescription) {
    setState(() {
      _recipe.instructions.removeWhere((e) => (e.instructionTitle == sectionTitle) && (e.instructionDescription == sectionDescription));
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeSummary = ModalRoute.of(context)!.settings.arguments as RecipeSummary;
    var recipeId = recipeSummary.id;
    return Scaffold(
      appBar: const CestamosBar(),
      body: FutureBuilder<bool>(
        future: _refreshRecipe(recipeId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var success = snapshot.data!;
          if (!success) {
            return const Center(
              child: Text("Algo de errado aconteceu na receita. Tente novamente mais tarde!"),
            );
          }

          return Center(
            child: SingleChildScrollView(
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
                        "Editar minha receita",
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
                                          initialValue: _recipe.recipeName,
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
                                              _recipe.recipeName = recipeName;
                                            }
                                          },
                                          textInputAction: TextInputAction.done,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          initialValue: _recipe.description,
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
                                              _recipe.description = description;
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
                                                initialValue: _recipe.prepTime,
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
                                                    _recipe.prepTime = prepTime;
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
                                                initialValue: _recipe.cookingTime,
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
                                                    _recipe.cookingTime = cookingTime;
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
                                                initialValue: _recipe.restingTime,
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
                                                    _recipe.restingTime = restingTime;
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
                                        for (var item in _recipe.ingredients)
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                                      IconButton(
                                                        iconSize: 20,
                                                        padding: EdgeInsets.zero,
                                                        constraints: const BoxConstraints(),
                                                        onPressed: () => _removeItem(
                                                          item.ingredientName,
                                                          item.ingredientQuantity,
                                                        ),
                                                        icon: Icon(
                                                          Icons.cancel,
                                                          color: Theme.of(context).colorScheme.inversePrimary,
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
                          for (var i = 0; i < _recipe.instructions.length; i++)
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
                                                        _recipe.instructions[i].instructionTitle,
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                    onPressed: () => _removeSection(
                                                      _recipe.instructions[i].instructionTitle,
                                                      _recipe.instructions[i].instructionDescription,
                                                    ),
                                                    icon: Icon(
                                                      Icons.cancel,
                                                      color: Theme.of(context).colorScheme.inversePrimary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                _recipe.instructions[i].instructionDescription,
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
                          value: !_recipe.isPublic,
                          onChanged: (value) {
                            setState(() {
                              _recipe.isPublic = !value;
                            });
                          },
                        ),
                      ],
                    ),
                    FormButton(
                      text: "Atualizar",
                      icon: Icons.refresh,
                      onPressed: () {
                        _editRecipe();
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
        },
      ),
    );
  }
}
