class Recipe {
  String id;
  String name;
  double rating;
  int estimatedTime;
  int servings;
  int numOfCalories;
  List<dynamic> ingredients;
  List<String> steps;
  List<String> lists;
  String photoPath;

  Recipe({
    required this.id,
    required this.name,
    required this.rating,
    required this.estimatedTime,
    required this.servings,
    required this.numOfCalories,
    required this.ingredients,
    required this.steps,
    required this.lists,
    required this.photoPath,
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
      steps: json['steps'].cast<String>(),
      lists: json['lists'].cast<String>(),
      photoPath: json['photoPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'estimatedTime': estimatedTime,
      'servings': servings,
      'numOfCalories': numOfCalories,
      'ingredients': ingredients,
      'steps': steps,
      'lists': lists,
      'photoPath': photoPath,
    };
  }
}
