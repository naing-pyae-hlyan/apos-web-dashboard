class Category {
  String? id;
  final String readableId;
  final String name;
  final String description;

  Category({
    this.id,
    required this.readableId,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json, String docId) {
    return Category(
      id: docId,
      readableId: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': readableId,
      'name': name,
      'description': description,
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Category && id == other.id;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;

  static Category get allCategoriesValue => Category(
        id: "all-category",
        readableId: "all-category",
        name: "All Category",
        description: "",
      );

  static Category get selectCategoriesValue => Category(
        id: "select-category",
        readableId: "select-category",
        name: "Select Category",
        description: "",
      );

  bool get isDropdownTitle => id == "select-category" || id == "all-category";
}
