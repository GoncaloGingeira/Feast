class Recipe {
  String id;
  String name;
  double rating;
  int estimatedTime;
  int servings;
  int numOfCalories;
  List<dynamic> ingredients;
  List<String> instructions;
  List<String> lists;
  String photoPath;

  Recipe(
      {required this.id,
      required this.name,
      required this.rating,
      required this.estimatedTime,
      required this.servings,
      required this.numOfCalories,
      required this.ingredients,
      required this.instructions,
      required this.lists,
      required this.photoPath});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    print(json);
    return Recipe(
        id: json['id'],
        name: json['name'],
        rating: json['rating'],
        estimatedTime: json['time'],
        servings: json['servings'],
        numOfCalories: json['numOfCalories'],
        ingredients: json['ingredients'].cast<String>(),
        instructions: json['instructions'].cast<String>(),
        lists: json['lists'].cast<String>(),
        photoPath: json['photo']);
  }
}
