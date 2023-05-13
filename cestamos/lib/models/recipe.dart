import './item.dart';
import './user.dart';

class Recipe {
  int id;
  int userId;
  String recipeName;
  // LEMBRAR DE ADD OS INGREDIENTE: É TEXTO? É ITEM?
  // List<item> items; ?????
  String description;
  int peopleServed;
  String instructions;
  int prepTime;
  int cookingTime;
  int restingTime;
  bool isPublic;
  Recipe(
      {this.id = 0,
      this.userId = 0,
      this.recipeName = "",
      this.description = "",
      // this.items = const []
      this.peopleServed = 0,
      this.instructions = "",
      this.prepTime = 0,
      this.cookingTime = 0,
      this.restingTime = 0,
      this.isPublic = false});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        id: json['recipe_id'] as int,
        userId: json['user_id'] as int,
        recipeName: json['name'] as String,
        description: json['description'] as String,
        peopleServed: json['people_served'] as int,
        // ingredients: json['ingredients'] ITEMS? LIST? STRING?
        instructions: json['instructions'] as String,
        prepTime: json['prep_time'] as int,
        cookingTime: json['cooking_time'] as int,
        restingTime: json['resting_time'] as int,
        isPublic: json['is_public'] as bool);
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
