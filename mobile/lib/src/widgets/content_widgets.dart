import 'package:flutter/material.dart';
import '../models.dart';
import '../theme.dart';

Color coverColor(String key) => switch (key) {
  'mint' => const Color(0xFF16A394),
  'orange' => const Color(0xFFEA7C3D),
  'violet' => const Color(0xFF7857C7),
  _ => const Color(0xFF173B7A),
};

class CoverArt extends StatelessWidget {
  const CoverArt({
    super.key,
    required this.colorKey,
    required this.label,
    this.icon = Icons.functions_rounded,
    this.aspectRatio = 1.35,
  });
  final String colorKey;
  final String label;
  final IconData icon;
  final double aspectRatio;
  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: aspectRatio,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            coverColor(colorKey),
            coverColor(colorKey).withValues(alpha: .72),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -12,
            top: -15,
            child: Icon(
              icon,
              size: 100,
              color: Colors.white.withValues(alpha: .12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(height: 8),
                Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class AccessBadge extends StatelessWidget {
  const AccessBadge({super.key, required this.accessType});
  final AccessType accessType;
  @override
  Widget build(BuildContext context) {
    final premium = accessType == AccessType.premium;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: premium ? const Color(0xFFFFF1D8) : const Color(0xFFE7F7EF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        premium ? 'Premium' : 'Miễn phí',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: premium ? const Color(0xFFA05B00) : const Color(0xFF087A4C),
        ),
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  const ResourceCard({
    super.key,
    required this.resource,
    required this.onTap,
    this.compact = false,
  });
  final LearningResource resource;
  final VoidCallback onTap;
  final bool compact;
  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: compact
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CoverArt(
                    colorKey: resource.thumbnail,
                    label: 'TOÁN ${resource.grade}',
                  ),
                  const SizedBox(height: 10),
                  Text(
                    resource.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  AccessBadge(accessType: resource.accessType),
                ],
              )
            : Row(
                children: [
                  SizedBox(
                    width: 102,
                    child: CoverArt(
                      colorKey: resource.thumbnail,
                      label: 'TOÁN ${resource.grade}',
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          resource.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              resource.resourceType == ResourceType.document
                                  ? Icons.description_outlined
                                  : Icons.play_circle_outline,
                              size: 17,
                              color: brandBlue,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              resource.resourceType == ResourceType.document
                                  ? 'Tài liệu'
                                  : 'Bài giảng',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF657086),
                              ),
                            ),
                            const Spacer(),
                            AccessBadge(accessType: resource.accessType),
                          ],
                        ),
                        if (resource.progress != null) ...[
                          const SizedBox(height: 12),
                          LinearProgressIndicator(
                            value: resource.progress,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
      ),
    ),
  );
}

String formatPrice(int value) {
  final raw = value.toString();
  final output = StringBuffer();
  for (var i = 0; i < raw.length; i++) {
    if (i > 0 && (raw.length - i) % 3 == 0) output.write('.');
    output.write(raw[i]);
  }
  return '$outputđ';
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, this.message = 'Chưa có nội dung phù hợp'});
  final String message;
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.inbox_outlined, size: 48, color: Color(0xFF98A2B6)),
          const SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF657086)),
          ),
        ],
      ),
    ),
  );
}
