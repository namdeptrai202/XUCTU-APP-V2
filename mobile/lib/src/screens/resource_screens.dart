import 'package:flutter/material.dart';
import '../data.dart';
import '../models.dart';
import '../theme.dart';
import '../widgets/content_widgets.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.category,
    required this.grade,
    required this.repository,
  });
  final Category category;
  final int grade;
  final ContentRepository repository;
  @override
  Widget build(BuildContext context) => ResourceCollectionScreen(
    title: category.name,
    subtitle: 'Lớp $grade • ${category.name}',
    resources: repository.resourcesForCategory(grade, category.id),
  );
}

class ResourceCollectionScreen extends StatelessWidget {
  const ResourceCollectionScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.resources,
  });
  final String title;
  final String subtitle;
  final List<LearningResource> resources;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: resources.isEmpty
        ? const EmptyState()
        : ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
            itemCount: resources.length + 1,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF657086),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }
              final resource = resources[index - 1];
              return ResourceCard(
                resource: resource,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ResourceDetailScreen(resource: resource),
                  ),
                ),
              );
            },
          ),
  );
}

class ResourceDetailScreen extends StatelessWidget {
  const ResourceDetailScreen({super.key, required this.resource});
  final LearningResource resource;
  @override
  Widget build(BuildContext context) {
    final document = resource.resourceType == ResourceType.document;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: FilledButton.icon(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                document
                    ? 'Trình đọc tài liệu sẽ có ở giai đoạn sau.'
                    : 'Trình phát video sẽ có ở giai đoạn sau.',
              ),
            ),
          ),
          icon: Icon(
            document
                ? Icons.chrome_reader_mode_outlined
                : Icons.play_arrow_rounded,
          ),
          label: Text(document ? 'Đọc tài liệu' : 'Xem bài giảng'),
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 620),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CoverArt(
                  colorKey: resource.thumbnail,
                  label:
                      'TOÁN ${resource.grade}\n${document ? 'TÀI LIỆU' : 'BÀI GIẢNG'}',
                  icon: document
                      ? Icons.description_rounded
                      : Icons.play_circle_fill_rounded,
                  aspectRatio: 1.65,
                ),
                const SizedBox(height: 24),
                AccessBadge(accessType: resource.accessType),
                const SizedBox(height: 12),
                Text(
                  resource.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        document
                            ? Icons.auto_stories_outlined
                            : Icons.schedule_rounded,
                        color: brandBlue,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        document
                            ? '${resource.pageCount} trang'
                            : resource.duration ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      Text(
                        'Lớp ${resource.grade}',
                        style: const TextStyle(color: Color(0xFF657086)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Giới thiệu',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  document
                      ? 'Tài liệu được biên soạn rõ ràng, bám sát chương trình và có hướng dẫn giải chi tiết để bạn chủ động ôn tập.'
                      : 'Bài giảng trình bày từng bước dễ hiểu, đi kèm ví dụ minh hoạ giúp bạn nắm chắc kiến thức trọng tâm.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
