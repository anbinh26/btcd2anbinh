/// Khoảng thời gian nhắc lại tính từ ngày sự việc trong nhật ký.
enum ReminderInterval {
  threeMonths('3 tháng sau'),
  oneYear('1 năm sau'),
  tenYears('10 năm');

  const ReminderInterval(this.label);
  final String label;
}

enum ReminderMethod {
  ringtone('Nhắc bằng chuông điện thoại'),
  email('Nhắc qua email'),
  notification('Nhắc dựa vào thông báo');

  const ReminderMethod(this.label);
  final String label;
}

class DiaryEntry {
  const DiaryEntry({
    required this.title,
    required this.eventDate,
    this.imagePath,
    this.remindLater = false,
    this.reminderInterval,
    this.reminderMethod,
  });

  final String title;
  final DateTime eventDate;
  final String? imagePath;
  final bool remindLater;
  final ReminderInterval? reminderInterval;
  final ReminderMethod? reminderMethod;
}
