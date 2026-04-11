import 'package:flutter/material.dart';

import '../models/diary_entry.dart';
import '../widgets/gradient_scaffold.dart';
import '../widgets/gradient_title.dart';
import 'create_diary_screen.dart';

class DiaryHomeScreen extends StatefulWidget {
  const DiaryHomeScreen({super.key});

  @override
  State<DiaryHomeScreen> createState() => _DiaryHomeScreenState();
}

class _DiaryHomeScreenState extends State<DiaryHomeScreen> {
  late List<DiaryEntry> _entries;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _entries = [
      DiaryEntry(
        title: 'Hiến máu tình nguyện EAUT một hành động ý nghĩa',
        eventDate: now.subtract(const Duration(days: 2)),
      ),
      DiaryEntry(
        title: 'Họ đo ván IT 3 4-0 chung kết',
        eventDate: now.subtract(const Duration(days: 5)),
      ),
      DiaryEntry(
        title: 'Cảm xúc chung kết',
        eventDate: now.subtract(const Duration(days: 7)),
      ),
    ];
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  Future<void> _openCreate() async {
    final created = await Navigator.push<DiaryEntry>(
      context,
      MaterialPageRoute(builder: (_) => const CreateDiaryScreen()),
    );
    if (created != null && mounted) {
      setState(() => _entries.insert(0, created));
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final cardGradients = <List<Color>>[
      [const Color(0xFFFFFFFF), cs.tertiaryContainer.withValues(alpha: 0.85)],
      [const Color(0xFFFFFFFF), cs.secondaryContainer.withValues(alpha: 0.9)],
      [const Color(0xFFFFFFFF), cs.primaryContainer.withValues(alpha: 0.95)],
    ];

    return GradientScaffold(
      appBar: AppBar(
        title: const GradientTitle(text: 'Nhật ký'),
        backgroundColor: Colors.transparent,
        foregroundColor: cs.onSurface,
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [cs.secondary, cs.tertiary, cs.primary],
          ),
          boxShadow: [
            BoxShadow(
              color: cs.tertiary.withValues(alpha: 0.5),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [cs.primary, cs.tertiary, cs.secondary],
            ),
          ),
          child: FloatingActionButton(
            onPressed: _openCreate,
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add_rounded, size: 32),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
          itemCount: _entries.length,
          itemBuilder: (context, index) {
            final e = _entries[index];
            final g = cardGradients[index % cardGradients.length];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                elevation: 3,
                shadowColor: cs.primary.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: g,
                    ),
                    border: Border.all(
                      color: Color.lerp(cs.primary, cs.tertiary, 0.5)!.withValues(alpha: 0.2),
                    ),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Container(
                          width: 5,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [cs.primary, cs.tertiary, cs.secondary],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: cs.primary.withValues(alpha: 0.35),
                                blurRadius: 6,
                                offset: const Offset(2, 0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.title,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      height: 1.25,
                                      color: const Color(0xFF2D1B3D),
                                    ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.event_rounded,
                                    size: 16,
                                    color: cs.tertiary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    _formatDate(e.eventDate),
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: cs.primary.withValues(alpha: 0.75),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            );
          },
        ),
      ),
    );
  }
}
