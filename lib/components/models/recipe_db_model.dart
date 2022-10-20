final String tableRecipe = 'savedRecipes';

class RecipeFields {
  static final List<String> values = [id, title, image];
  static final String id = '_id';
  static final String title = 'title';
  static final String image = 'image';
}

class RecipeDb {
  final int? id;
  final String title;
  final String image;

  RecipeDb(this.id, this.title, this.image);

  RecipeDb copy({
    int? id,
    String? title,
    String? image,
  }) =>
      RecipeDb(
        id ?? this.id,
        title ?? this.title,
        image ?? this.image,
      );

  static RecipeDb fromJson(Map<String, Object?> json) => RecipeDb(
        json[RecipeFields.id] as int?,
        json[RecipeFields.title] as String,
        json[RecipeFields.image] as String,
      );

  Map<String, Object?> toJson() => {
        RecipeFields.id: id,
        RecipeFields.title: title,
        RecipeFields.image: image,
      };
}
