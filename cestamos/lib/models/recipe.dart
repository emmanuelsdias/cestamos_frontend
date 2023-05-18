import './item.dart';
import './user.dart';
import 'dart:convert';

class Instruction {
  String instructionTitle;
  String instructionDescription;

  Instruction({this.instructionTitle = "", this.instructionDescription = ""});

  factory Instruction.fromCustomJson(String customJson) {
    customJson = customJson.replaceAll('#', '"');
    customJson = customJson.replaceAll('&', ',');
    Map<String, dynamic> map = json.decode(customJson);
    return Instruction(
      instructionTitle: map['instruction_title'] as String,
      instructionDescription: map['instruction_description'] as String,
    );
  }

  String toCustomJson() {
    return '{#instruction_title#: #$instructionTitle#& #instruction_description#: #$instructionDescription#}';
  }
}

class Instructions {
  static List<Instruction> instructionListfromCustomString(String customJson) {
    customJson = customJson.replaceAll('[', '').replaceAll(']', '');
    if (customJson == "") {
      return [];
    }
    var customJsons = customJson.split(',');
    List<Instruction> instructions =
        customJsons.map((e) => Instruction.fromCustomJson(e)).toList();
    return instructions;
  }

  static String instructionList2CustomString(List<Instruction> instructions) {
    String customJson = '[';
    for (var i = 0; i < instructions.length; i++) {
      customJson += instructions[i].toCustomJson();
      if (i != instructions.length - 1) {
        customJson += ',';
      }
    }
    customJson += ']';
    return customJson;
  }
}

class Ingredient {
  String ingredientName;
  String ingredientQuantity;

  Ingredient({this.ingredientName = "", this.ingredientQuantity = ""});

  factory Ingredient.fromCustomJson(String customJson) {
    customJson = customJson.replaceAll('#', '"');
    customJson = customJson.replaceAll('&', ',');
    Map<String, dynamic> map = json.decode(customJson);
    return Ingredient(
      ingredientName: map['ingredient_name'] as String,
      ingredientQuantity: map['ingredient_quantity'] as String,
    );
  }

  String toCustomJson() {
    return '{#ingredient_name#: #$ingredientName#& #ingredient_quantity#: #$ingredientQuantity#}';
  }
}

class Ingredients {
  static List<Ingredient> ingredientListfromCustomString(String customJson) {
    customJson = customJson.replaceAll('[', '').replaceAll(']', '');
    if (customJson == "") {
      return [];
    }
    var customJsons = customJson.split(',');
    List<Ingredient> ingredients =
        customJsons.map((e) => Ingredient.fromCustomJson(e)).toList();

    return ingredients;
  }

  static String ingredientList2CustomString(List<Ingredient> ingredients) {
    String customJson = '[';
    for (var i = 0; i < ingredients.length; i++) {
      customJson += ingredients[i].toCustomJson();
      if (i != ingredients.length - 1) {
        customJson += ',';
      }
    }
    customJson += ']';
    return customJson;
  }
}

class Recipe {
  int id;
  int authorUserId;
  String authorUserName;
  String recipeName;
  List<Ingredient> ingredients;
  String description;
  int peopleServed;
  List<Instruction> instructions;
  String prepTime;
  String cookingTime;
  String restingTime;
  bool isPublic;
  Recipe({
    this.id = 0,
    this.authorUserId = 0,
    this.authorUserName = "",
    this.recipeName = "",
    this.description = "",
    this.ingredients = const [],
    this.peopleServed = 0,
    this.instructions = const [],
    this.prepTime = "-1",
    this.cookingTime = "-1",
    this.restingTime = "-1",
    this.isPublic = false,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        id: json['recipe_id'] as int,
        authorUserId: json['author_user_id'] as int,
        authorUserName: json['author_user_name'] as String,
        recipeName: json['name'] as String,
        description: json['description'] as String,
        peopleServed: json['people_served'] as int,
        ingredients: Ingredients.ingredientListfromCustomString(
            json['ingredients'] as String),
        instructions: Instructions.instructionListfromCustomString(
            json['instructions'] as String),
        prepTime: json['prep_time'] as String,
        cookingTime: json['cooking_time'] as String,
        restingTime: json['resting_time'] as String,
        isPublic: json['is_public'] as bool);
  }

  String get ingredientsString {
    return Ingredients.ingredientList2CustomString(ingredients);
  }

  String get instructionsString {
    return Instructions.instructionList2CustomString(instructions);
  }
}

class RecipeSummary {
  RecipeSummary({
    required this.id,
    required this.recipeName,
    required this.description,
    required this.prepTime,
    required this.cookingTime,
    required this.restingTime,
  });

  int id;
  String recipeName;
  String description;
  String prepTime;
  String cookingTime;
  String restingTime;

  factory RecipeSummary.fromJson(Map<String, dynamic> json) {
    return RecipeSummary(
      id: json['recipe_id'] as int,
      recipeName: json['name'] as String,
      description: json['description'] as String,
      prepTime: json['prep_time'] as String,
      cookingTime: json['cooking_time'] as String,
      restingTime: json['resting_time'] as String,
    );
  }
}
