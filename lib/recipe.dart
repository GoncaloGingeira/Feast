class Recipe {
  int id;
  String name;
  double rating;
  int estimatedTime;
  int servings;
  int numOfCalories;
  List<dynamic> ingredients;
  List<String> instructions;

  Recipe({
    required this.id,
    required this.name,
    required this.rating,
    required this.estimatedTime,
    required this.servings,
    required this.numOfCalories,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
        id: json['id'],
        name: json['name'],
        rating: json['rating'],
        estimatedTime: json['estimatedTime'],
        servings: json['servings'],
        numOfCalories: json['numOfCalories'],
        ingredients: json['ingredients'].cast<String>(),
        instructions: json['instructions'].cast<String>());
  }
}
