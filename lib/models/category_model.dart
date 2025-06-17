class Category {
  final String id;
  final String name;
  final List<String> subCategory;

  Category({
    required this.id,
    required this.name,
    required this.subCategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      subCategory: List<String>.from(json['subCategory']),
    );
  }

  @override
  String toString() =>
      'Category(id: $id, name: $name, subCategory: $subCategory)';
}
