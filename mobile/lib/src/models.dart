enum ResourceType { document, video }

enum AccessType { free, premium }

class Category {
  const Category({required this.id, required this.name, required this.icon});
  final int id;
  final String name;
  final String icon;
}

class LearningResource {
  const LearningResource({
    required this.id,
    required this.title,
    required this.resourceType,
    required this.grade,
    required this.categoryId,
    required this.thumbnail,
    required this.accessType,
    this.progress,
    this.pageCount,
    this.duration,
  });
  final int id;
  final String title;
  final ResourceType resourceType;
  final int grade;
  final int categoryId;
  final String thumbnail;
  final AccessType accessType;
  final double? progress;
  final int? pageCount;
  final String? duration;
}

class Book {
  const Book({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.cover,
    this.salePrice,
  });
  final int id;
  final String title;
  final String description;
  final int price;
  final int? salePrice;
  final String cover;
}
