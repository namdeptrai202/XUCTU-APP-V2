import 'models.dart';

abstract interface class ContentRepository {
  List<Category> get categories;
  List<LearningResource> resourcesForGrade(int grade);
  List<LearningResource> resourcesForCategory(int grade, int categoryId);
  List<Book> get books;
}

class DummyContentRepository implements ContentRepository {
  const DummyContentRepository();

  @override
  List<Category> get categories => const [
    Category(id: 1, name: 'Chuyên đề', icon: 'π'),
    Category(id: 2, name: 'Đề cương', icon: '✎'),
    Category(id: 3, name: 'Giữa HK I', icon: 'Ⅰ'),
    Category(id: 4, name: 'HK I', icon: '✓'),
    Category(id: 5, name: 'Giữa HK II', icon: 'Ⅱ'),
    Category(id: 6, name: 'HK II', icon: '★'),
    Category(id: 7, name: 'Khảo sát chất lượng', icon: '↗'),
    Category(id: 8, name: 'Kỳ thi HSG', icon: '♛'),
    Category(id: 9, name: 'Giáo án dạy học', icon: '▤'),
    Category(id: 10, name: 'Mẹo học tập', icon: '⚡'),
  ];

  static const _templates = [
    (
      'Chuyên đề phương trình bậc hai',
      ResourceType.document,
      1,
      AccessType.free,
    ),
    ('Tổng ôn kiến thức trọng tâm', ResourceType.video, 2, AccessType.free),
    ('Đề kiểm tra giữa học kỳ I', ResourceType.document, 3, AccessType.free),
    (
      'Bộ đề học kỳ I có lời giải',
      ResourceType.document,
      4,
      AccessType.premium,
    ),
    ('Chữa đề giữa học kỳ II', ResourceType.video, 5, AccessType.premium),
    ('Đề thi học kỳ II chọn lọc', ResourceType.document, 6, AccessType.free),
    ('Khảo sát chất lượng đầu năm', ResourceType.document, 7, AccessType.free),
    ('50 đề thi HSG Toán', ResourceType.document, 8, AccessType.premium),
    ('Chữa đề HSG Toán', ResourceType.video, 8, AccessType.free),
    (
      'Giáo án phát triển năng lực',
      ResourceType.document,
      9,
      AccessType.premium,
    ),
    ('5 mẹo giải nhanh hình học', ResourceType.video, 10, AccessType.free),
  ];

  @override
  List<LearningResource> resourcesForGrade(int grade) => [
    for (var i = 0; i < _templates.length; i++)
      LearningResource(
        id: grade * 100 + i,
        title: '${_templates[i].$1} lớp $grade',
        resourceType: _templates[i].$2,
        grade: grade,
        categoryId: _templates[i].$3,
        thumbnail: ['navy', 'mint', 'orange', 'violet'][i % 4],
        accessType: _templates[i].$4,
        progress: i == 0 ? .38 : null,
        pageCount: _templates[i].$2 == ResourceType.document
            ? 48 + i * 3
            : null,
        duration: _templates[i].$2 == ResourceType.video
            ? '${18 + i * 4} phút'
            : null,
      ),
  ];

  @override
  List<LearningResource> resourcesForCategory(int grade, int categoryId) =>
      resourcesForGrade(
        grade,
      ).where((item) => item.categoryId == categoryId).toList();

  @override
  List<Book> get books => const [
    Book(
      id: 1,
      title: 'Bứt phá Toán 9',
      description:
          'Hệ thống kiến thức, ví dụ và bài tập theo chuyên đề dành cho học sinh lớp 9.',
      price: 189000,
      salePrice: 149000,
      cover: 'navy',
    ),
    Book(
      id: 2,
      title: 'Tư duy Toán học',
      description:
          'Rèn luyện tư duy giải toán qua những bài tập chọn lọc và lời giải trực quan.',
      price: 165000,
      cover: 'orange',
    ),
    Book(
      id: 3,
      title: 'Chinh phục kỳ thi HSG',
      description:
          'Bộ bài toán nâng cao, chiến lược làm bài và các đề thi thử.',
      price: 219000,
      salePrice: 199000,
      cover: 'violet',
    ),
  ];
}
