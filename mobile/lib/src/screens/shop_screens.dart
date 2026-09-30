import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';
import '../widgets/content_widgets.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key, required this.books});
  final List<Book> books;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Nhà sách Xuctu')),
    body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 4, 20, 22),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFE9D5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sách hay cho người mê Toán',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: ink,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Khám phá bộ sách được tuyển chọn',
                        style: TextStyle(color: Color(0xFF745139)),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.auto_stories_rounded,
                  size: 58,
                  color: Color(0xFFDA773B),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
          sliver: SliverGrid.builder(
            itemCount: books.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 240,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: .64,
            ),
            itemBuilder: (context, index) {
              final book = books[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BookDetailScreen(book: book),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CoverArt(
                          colorKey: book.cover,
                          label: book.title,
                          icon: Icons.menu_book_rounded,
                          aspectRatio: 1.15,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          book.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                        Text(
                          formatPrice(book.salePrice ?? book.price),
                          style: const TextStyle(
                            color: brandBlue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (book.salePrice != null)
                          Text(
                            formatPrice(book.price),
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                              color: Color(0xFF8992A5),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key, required this.book});
  final Book book;
  void _notice(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Chi tiết sách')),
    bottomNavigationBar: SafeArea(
      minimum: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () =>
                  _notice(context, 'Bản đọc thử sẽ có trong giai đoạn sau.'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
              ),
              child: const Text('Đọc thử'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: () => _notice(
                context,
                'Tính năng mua sách chưa có trong bản thử nghiệm.',
              ),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
              ),
              child: const Text('Mua sách'),
            ),
          ),
        ],
      ),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 240,
                  child: CoverArt(
                    colorKey: book.cover,
                    label: book.title,
                    icon: Icons.menu_book_rounded,
                    aspectRatio: .82,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                book.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    formatPrice(book.salePrice ?? book.price),
                    style: const TextStyle(
                      fontSize: 23,
                      color: brandBlue,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (book.salePrice != null) ...[
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: Text(
                        formatPrice(book.price),
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Color(0xFF8992A5),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Giới thiệu sách',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                book.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
