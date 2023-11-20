class Recipe {
  String id;
  String name;
  double rating;
  int estimatedTime;
  int servings;
  int numOfCalories;
  List<dynamic> ingredients;
  List<String> instructions;
  String photoPath;
  List<String> lists;

  Recipe(
      {required this.id,
      required this.name,
      required this.rating,
      required this.estimatedTime,
      required this.servings,
      required this.numOfCalories,
      required this.ingredients,
      required this.instructions,
      required this.photoPath,
      required this.lists});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    print(json);
    return Recipe(
        id: json['id'],
        name: json['name'],
        rating: json['rating'],
        estimatedTime: json['time'],
        servings: json['servings'],
        numOfCalories: json['numOfCalories'],
        ingredients: json['ingredients'].cast<Map<String, dynamic>>(),
        instructions: json['steps'].cast<String>(),
        lists: json['lists'].cast<String>(),
        photoPath: json['photo']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'rating': rating,
      'time': estimatedTime,
      'servings': servings,
      'numOfCalories': numOfCalories,
      'ingredients': ingredients,
      'steps': instructions,
      'lists': lists,
      'photo': photoPath,
    };
  }
}
