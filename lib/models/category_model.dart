class Category {
  String? id;
  final String readalbeId;
  final String name;
  final String description;

  Category({
    this.id,
    required this.readalbeId,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json, String docId) {
    return Category(
      id: docId,
      readalbeId: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': readalbeId,
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

  static Category forDropdown() => Category(
        id: "select-category",
        readalbeId: "select-category",
        name: "Select Category",
        description: "",
      );

  bool get isDropdownTitle => id == "select-category";
}
