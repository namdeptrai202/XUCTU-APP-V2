import 'package:flutter/material.dart';
import '../theme.dart';

class GradeSelectionScreen extends StatefulWidget {
  const GradeSelectionScreen({super.key, required this.onSelected});
  final ValueChanged<int> onSelected;
  @override
  State<GradeSelectionScreen> createState() => _GradeSelectionScreenState();
}

class _GradeSelectionScreenState extends State<GradeSelectionScreen> {
  int? selected;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: brandBlue,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Xu',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Bạn đang học lớp mấy?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Chọn lớp để Xuctu hiển thị tài liệu phù hợp với bạn.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF657086), height: 1.5),
                ),
                const SizedBox(height: 32),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final grade in [6, 7, 8, 9, 10, 11, 12])
                      ChoiceChip(
                        label: SizedBox(
                          width: 50,
                          child: Text(
                            'Lớp $grade',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        selected: selected == grade,
                        onSelected: (_) => setState(() => selected = grade),
                        selectedColor: brandBlue,
                        labelStyle: TextStyle(
                          color: selected == grade ? Colors.white : ink,
                          fontWeight: FontWeight.w700,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                  ],
                ),
                const Spacer(),
                FilledButton(
                  onPressed: selected == null
                      ? null
                      : () => widget.onSelected(selected!),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(54),
                  ),
                  child: const Text(
                    'Bắt đầu học',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
