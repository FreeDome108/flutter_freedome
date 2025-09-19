class Category {
  final int id;
  final String name;
  final String? description;
  final String? image;
  final int? parentId;
  final int level;
  final int position;
  final bool isActive;
  final String? urlKey;
  final String? metaTitle;
  final String? metaDescription;
  final String? metaKeywords;
  final List<Category> children;

  Category({
    required this.id,
    required this.name,
    this.description,
    this.image,
    this.parentId,
    required this.level,
    required this.position,
    required this.isActive,
    this.urlKey,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.children = const [],
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      image: json['image'],
      parentId: json['parent_id'],
      level: json['level'] ?? 0,
      position: json['position'] ?? 0,
      isActive: json['is_active'] ?? true,
      urlKey: json['url_key'],
      metaTitle: json['meta_title'],
      metaDescription: json['meta_description'],
      metaKeywords: json['meta_keywords'],
      children: (json['children'] as List<dynamic>?)
              ?.map((child) => Category.fromJson(child))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'parent_id': parentId,
      'level': level,
      'position': position,
      'is_active': isActive,
      'url_key': urlKey,
      'meta_title': metaTitle,
      'meta_description': metaDescription,
      'meta_keywords': metaKeywords,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  bool get hasChildren => children.isNotEmpty;
  bool get isRoot => parentId == null || parentId == 0;
}





