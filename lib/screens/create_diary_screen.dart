import 'package:flutter/material.dart';

import '../models/diary_entry.dart';
import '../widgets/gradient_scaffold.dart';
import '../widgets/gradient_title.dart';
import '../widgets/labeled_field.dart';

class CreateDiaryScreen extends StatefulWidget {
  const CreateDiaryScreen({super.key});

  @override
  State<CreateDiaryScreen> createState() => _CreateDiaryScreenState();
}

class _CreateDiaryScreenState extends State<CreateDiaryScreen> {
  final _titleCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _imageCtrl = TextEditingController();
  DateTime _eventDate = DateTime.now();
  bool _remindLater = true;
  ReminderInterval _interval = ReminderInterval.threeMonths;
  ReminderMethod _method = ReminderMethod.ringtone;

  @override
  void initState() {
    super.initState();
    _dateCtrl.text = _formatDate(_eventDate);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _dateCtrl.dispose();
    _imageCtrl.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _eventDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _eventDate = picked;
        _dateCtrl.text = _formatDate(_eventDate);
      });
    }
  }

  void _submit() {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập tiêu đề')),
      );
      return;
    }
    final path = _imageCtrl.text.trim();
    Navigator.of(context).pop(
      DiaryEntry(
        title: title,
        eventDate: _eventDate,
        imagePath: path.isEmpty ? null : path,
        remindLater: _remindLater,
        reminderInterval: _remindLater ? _interval : null,
        reminderMethod: _remindLater ? _method : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GradientScaffold(
      appBar: AppBar(
        title: const GradientTitle(text: 'Tạo nhật ký'),
        backgroundColor: Colors.transparent,
        foregroundColor: cs.onSurface,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: cs.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LabeledTextField(
                label: 'Tiêu đề',
                controller: _titleCtrl,
                hint: 'Nhập tiêu đề nhật ký',
              ),
              const SizedBox(height: 20),
              LabeledTextField(
                label: 'Thời gian',
                controller: _dateCtrl,
                readOnly: true,
                onTap: _pickDate,
                suffix: IconButton(
                  icon: Icon(Icons.calendar_month_rounded, color: cs.tertiary),
                  onPressed: _pickDate,
                ),
              ),
              const SizedBox(height: 20),
              LabeledTextField(
                label: 'Hình ảnh',
                controller: _imageCtrl,
                hint: 'Đường dẫn hoặc mô tả ảnh đính kèm',
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [cs.primary, cs.tertiary, cs.secondary],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: cs.primary.withValues(alpha: 0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: cs.surface.withValues(alpha: 0.94),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.notifications_active_rounded, color: cs.tertiary, size: 22),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Nhắc lại sau này',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: cs.primary,
                              ),
                        ),
                      ),
                      Switch(
                        value: _remindLater,
                        onChanged: (v) => setState(() => _remindLater = v),
                      ),
                    ],
                  ),
                ),
              ),
              if (_remindLater) ...[
                const SizedBox(height: 16),
                LabeledDropdown<ReminderInterval>(
                  label: 'Nhắc lại sau bao lâu (từ ngày sự việc)',
                  value: _interval,
                  items: ReminderInterval.values,
                  itemLabel: (e) => e.label,
                  onChanged: (v) {
                    if (v != null) setState(() => _interval = v);
                  },
                ),
                const SizedBox(height: 20),
                LabeledDropdown<ReminderMethod>(
                  label: 'Cách nhắc',
                  value: _method,
                  items: ReminderMethod.values,
                  itemLabel: (e) => e.label,
                  onChanged: (v) {
                    if (v != null) setState(() => _method = v);
                  },
                ),
              ],
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [cs.primary, cs.tertiary, cs.secondary],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: cs.primary.withValues(alpha: 0.45),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _submit,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.edit_note_rounded, color: Colors.white, size: 26),
                            const SizedBox(width: 10),
                            Text(
                              'Ghi lại nhật ký',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
