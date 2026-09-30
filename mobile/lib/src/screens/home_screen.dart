import 'package:flutter/material.dart';
import '../data.dart';
import '../models.dart';
import '../theme.dart';
import '../widgets/content_widgets.dart';
import 'resource_screens.dart';
import 'shop_screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.grade,
    required this.repository,
    required this.onGradeChanged,
  });
  final int grade;
  final ContentRepository repository;
  final ValueChanged<int> onGradeChanged;

  void _openResource(BuildContext context, LearningResource resource) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResourceDetailScreen(resource: resource),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final resources = repository.resourcesForGrade(grade);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _Header(grade: grade, onGradeChanged: onGradeChanged),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              sliver: SliverToBoxAdapter(
                child: TextField(
                  readOnly: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ResourceCollectionScreen(
                        title: 'Tìm kiếm',
                        subtitle: 'Nội dung nổi bật cho lớp $grade',
                        resources: resources,
                      ),
                    ),
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: 'Tìm tài liệu, đề thi, bài giảng...',
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: _SectionTitle(title: 'Khám phá theo chủ đề'),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverGrid.builder(
                itemCount: repository.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.35,
                ),
                itemBuilder: (context, index) {
                  final category = repository.categories[index];
                  return _CategoryCard(
                    category: category,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryScreen(
                          category: category,
                          grade: grade,
                          repository: repository,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: _ResourceSection(
                title: 'Tiếp tục học',
                resources: resources
                    .where((item) => item.progress != null)
                    .toList(),
                onTap: (item) => _openResource(context, item),
              ),
            ),
            SliverToBoxAdapter(
              child: _ResourceSection(
                title: 'Tài liệu mới',
                resources: resources
                    .where((item) => item.resourceType == ResourceType.document)
                    .take(3)
                    .toList(),
                onTap: (item) => _openResource(context, item),
              ),
            ),
            SliverToBoxAdapter(
              child: _ResourceSection(
                title: 'Bài giảng mới',
                resources: resources
                    .where((item) => item.resourceType == ResourceType.video)
                    .take(3)
                    .toList(),
                onTap: (item) => _openResource(context, item),
              ),
            ),
            SliverToBoxAdapter(child: _BookPreview(books: repository.books)),
            const SliverToBoxAdapter(child: SizedBox(height: 28)),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.grade, required this.onGradeChanged});
  final int grade;
  final ValueChanged<int> onGradeChanged;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
    decoration: const BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xFF1749B3), Color(0xFF2469E8)]),
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xin chào 👋',
                style: TextStyle(color: Colors.white.withValues(alpha: .8)),
              ),
              const SizedBox(height: 5),
              Text(
                'Sẵn sàng học Toán lớp $grade?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  height: 1.2,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        PopupMenuButton<int>(
          initialValue: grade,
          onSelected: onGradeChanged,
          itemBuilder: (_) => [
            for (final value in [6, 7, 8, 9, 10, 11, 12])
              PopupMenuItem(value: value, child: Text('Lớp $value')),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .16),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Text(
                  'Lớp $grade',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 26, 20, 14),
    child: Text(title, style: Theme.of(context).textTheme.titleLarge),
  );
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category, required this.onTap});
  final Category category;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: brandBlue.withValues(alpha: .09),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Text(
                category.icon,
                style: const TextStyle(
                  color: brandBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                category.name,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _ResourceSection extends StatelessWidget {
  const _ResourceSection({
    required this.title,
    required this.resources,
    required this.onTap,
  });
  final String title;
  final List<LearningResource> resources;
  final ValueChanged<LearningResource> onTap;
  @override
  Widget build(BuildContext context) {
    if (resources.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title),
        SizedBox(
          height: 228,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: resources.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, index) => SizedBox(
              width: 174,
              child: ResourceCard(
                resource: resources[index],
                compact: true,
                onTap: () => onTap(resources[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BookPreview extends StatelessWidget {
  const _BookPreview({required this.books});
  final List<Book> books;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _SectionTitle(title: 'Sách dành cho bạn'),
      SizedBox(
        height: 216,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: books.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (_, index) {
            final book = books[index];
            return SizedBox(
              width: 148,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookDetailScreen(book: book),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CoverArt(
                      colorKey: book.cover,
                      label: book.title,
                      icon: Icons.menu_book_rounded,
                      aspectRatio: 1.55,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.title,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatPrice(book.salePrice ?? book.price),
                      style: const TextStyle(
                        color: brandBlue,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}
