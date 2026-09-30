enum ResourceType { document, video }

enum AccessType { free, premium }

class Category {
  const Category({required this.id, required this.name, required this.icon});
  final int id;
  final String name;
  final String icon;
}

class Resource {
  const Resource({
    required this.id,
    required this.title,
    required this.resourceType,
    required this.grade,
    required this.categoryId,
    required this.thumbnailKey,
    required this.accessType,
    this.progress,
    this.pageCount,
    this.durationSeconds,
  });
  final int id;
  final String title;
  final ResourceType resourceType;
  final int grade;
  final int categoryId;
  final String thumbnailKey;
  final AccessType accessType;

  /// Normalized learning progress from 0.0 (not started) to 1.0 (complete).
  final double? progress;
  final int? pageCount;
  final int? durationSeconds;
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
