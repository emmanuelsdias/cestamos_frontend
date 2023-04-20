class Recipe {
  int id;
  int authorUserId;
  String authorUserName;
  String recipeName;
  String description;
  String ingredients;
  int peopleServed;
  String instructions;
  String prepTime;
  String cookingTime;
  String restingTime;
  bool isPublic;
  Recipe(
      {this.id = 0,
      this.authorUserId = 0,
      this.authorUserName = "",
      this.recipeName = "",
      this.description = "",
      // this.items = const []
      this.ingredients = "",
      this.peopleServed = 0,
      this.instructions = "",
      this.prepTime = "0",
      this.cookingTime = "0",
      this.restingTime = "0",
      this.isPublic = false});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        recipeName: json['name'] as String,
        description: json['description'] as String,
        ingredients: json['ingredients'] as String,
        peopleServed: json['people_served'] as int,
        instructions: json['instructions'] as String,
        prepTime: json['prep_time'] as String,
        cookingTime: json['cooking_time'] as String,
        restingTime: json['resting_time'] as String,
        isPublic: json['is_public'] as bool,
        id: json['recipe_id'] as int,
        authorUserId: json['author_user_id'] as int,
        authorUserName: json['author_user_name'] as String,
    );
  }
}

class RecipeSummary {
  int id;
  String recipeName;
  String description;
  String prepTime;
  String cookingTime;
  String restingTime;
  int authorUserId;
  String authorUserName;

  RecipeSummary({
    required this.id,
    required this.recipeName,
    required this.description,
    required this.prepTime,
    required this.cookingTime,
    required this.restingTime,
    required this.authorUserId,
    required this.authorUserName,
  });

  factory RecipeSummary.fromJson(Map<String, dynamic> json) {
    return RecipeSummary(
      id: json['recipe_id'] as int,
      recipeName: json['name'] as String,
      description: json['description'] as String,
      prepTime: json['prep_time'] as String,
      cookingTime: json['cooking_time'] as String,
      restingTime: json['resting_time'] as String,
      authorUserId: json['author_user_id'] as int,
      authorUserName: json['author_user_name'] as String,
    );
  }
}
