import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';
import 'screens/grade_selection_screen.dart';
import 'screens/main_shell.dart';
import 'theme.dart';

class XuctuApp extends StatefulWidget {
  const XuctuApp({super.key});
  @override
  State<XuctuApp> createState() => _XuctuAppState();
}

class _XuctuAppState extends State<XuctuApp> {
  static const _gradeKey = 'selected_grade';
  final ContentRepository _repository = const DummyContentRepository();
  int? _grade;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadGrade();
  }

  Future<void> _loadGrade() async {
    final preferences = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _grade = preferences.getInt(_gradeKey);
      _loading = false;
    });
  }

  Future<void> _selectGrade(int grade) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(_gradeKey, grade);
    if (mounted) setState(() => _grade = grade);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Xuctu',
    debugShowCheckedModeBanner: false,
    theme: buildTheme(),
    home: _loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : _grade == null
        ? GradeSelectionScreen(onSelected: _selectGrade)
        : MainShell(
            grade: _grade!,
            repository: _repository,
            onGradeChanged: _selectGrade,
          ),
  );
}
