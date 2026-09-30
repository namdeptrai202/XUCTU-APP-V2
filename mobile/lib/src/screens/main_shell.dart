import 'package:flutter/material.dart';
import '../data.dart';
import '../models.dart';
import 'home_screen.dart';
import 'resource_screens.dart';
import 'shop_screens.dart';

class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    required this.grade,
    required this.repository,
    required this.onGradeChanged,
  });
  final int grade;
  final ResourceRepository repository;
  final ValueChanged<int> onGradeChanged;
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final resources = widget.repository.resourcesForGrade(widget.grade);
    final pages = [
      HomeScreen(
        grade: widget.grade,
        repository: widget.repository,
        onGradeChanged: widget.onGradeChanged,
      ),
      ResourceCollectionScreen(
        title: 'Tài liệu',
        subtitle: 'Tài liệu Toán lớp ${widget.grade}',
        resources: resources
            .where((item) => item.resourceType == ResourceType.document)
            .toList(),
      ),
      ResourceCollectionScreen(
        title: 'Bài giảng',
        subtitle: 'Video bài giảng lớp ${widget.grade}',
        resources: resources
            .where((item) => item.resourceType == ResourceType.video)
            .toList(),
      ),
      ShopScreen(books: widget.repository.books),
      const _ProfilePlaceholder(),
    ];
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Trang chủ',
          ),
          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            label: 'Tài liệu',
          ),
          NavigationDestination(
            icon: Icon(Icons.play_circle_outline),
            label: 'Bài giảng',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Shop',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}

class _ProfilePlaceholder extends StatelessWidget {
  const _ProfilePlaceholder();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Cá nhân')),
    body: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: const Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 42,
                child: Icon(Icons.person_rounded, size: 42),
              ),
              SizedBox(height: 20),
              Text(
                'Học sinh Xuctu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 8),
              Text(
                'Tính năng tài khoản sẽ được hoàn thiện trong giai đoạn sau.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFF657086), height: 1.5),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
