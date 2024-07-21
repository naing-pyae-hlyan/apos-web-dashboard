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
}
