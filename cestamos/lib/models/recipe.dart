import './item.dart';
import './user.dart';

class Instruction {
  String instructionTitle;
  String instructionDescription;

  Instruction({this.instructionTitle = "", this.instructionDescription = ""});

  factory Instruction.fromCustomJson(String customJson) {
    customJson = customJson.replaceAll('#', '"');
    customJson = customJson.replaceAll('&', ',');
    var json = customJson as Map<String, dynamic>;
    return Instruction(
        instructionTitle: json['instruction_title'] as String,
        instructionDescription: json['instruction_description'] as String,
    );
  }

  String toCustomJson() {
    return '{#instruction_title#: #$instructionTitle#& #instruction_description#: #$instructionDescription#}';
  }
}

class Instructions {
  static List<Instruction> instructionListfromCustomString(String customJson) {
    customJson = customJson.replaceAll('[', '').replaceAll(']', '');
    var customJsons = customJson.split(',');
    List<Instruction> instructions = customJsons.map((e) => Instruction.fromCustomJson(e)).toList();
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
    var json = customJson as Map<String, dynamic>;
    return Ingredient(
        ingredientName: json['ingredient_name'] as String,
        ingredientQuantity: json['ingredient_quantity'] as String,
    );
  }

  String toCustomJson() {
    return '{#ingredient_name#: #$ingredientName#& #ingredient_quantity#: #$ingredientQuantity#}';
  }
}

class Ingredients {
  static List<Ingredient> ingredientListfromCustomString(String customJson) {
    customJson = customJson.replaceAll('[', '').replaceAll(']', '');
    var customJsons = customJson.split(',');
    List<Ingredient> ingredients = customJsons.map((e) => Ingredient.fromCustomJson(e)).toList();
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
  int userId;
  String recipeName;
  List<Ingredient> ingredients;
  String description;
  int peopleServed;
  List<Instruction> instructions;
  int prepTime;
  int cookingTime;
  int restingTime;
  bool isPublic;
  Recipe(
      {this.id = 0,
      this.userId = 0,
      this.recipeName = "",
      this.description = "",
      this.ingredients = const [],
      this.peopleServed = 0,
      this.instructions = const [],
      this.prepTime = 0,
      this.cookingTime = 0,
      this.restingTime = 0,
      this.isPublic = false,
    }
  );

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        id: json['recipe_id'] as int,
        userId: json['user_id'] as int,
        recipeName: json['name'] as String,
        description: json['description'] as String,
        peopleServed: json['people_served'] as int,
        ingredients: Ingredients.ingredientListfromCustomString(json['ingredients'] as String),
        instructions: Instructions.instructionListfromCustomString(json['instructions'] as String),
        prepTime: json['prep_time'] as int,
        cookingTime: json['cooking_time'] as int,
        restingTime: json['resting_time'] as int,
        isPublic: json['is_public'] as bool);
  }

  String get indredientsString {
    return Ingredients.ingredientList2CustomString(ingredients);
  }
  String get instructionsString {
    return Instructions.instructionList2CustomString(instructions);
  }
}

class RecipeSummary {
  int id;
  String recipeName;
  String description;
  int prepTime;
  int cookingTime;
  int restingTime;

  RecipeSummary({
    required this.id,
    required this.recipeName,
    required this.description,
    required this.prepTime,
    required this.cookingTime,
    required this.restingTime,
  });

  factory RecipeSummary.fromJson(Map<String, dynamic> json) {
    return RecipeSummary(
      id: json['recipe_id'] as int,
      recipeName: json['name'] as String,
      description: json['description'] as String,
      prepTime: json['prep_time'] as int,
      cookingTime: json['cooking_time'] as int,
      restingTime: json['resting_time'] as int,
    );
  }
}
