const String content = '''import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  // باکس‌های اصلی
  static const String contactsBox = 'contacts';
  static const String transactionsBox = 'transactions';
  static const String scheduledMsgsBox = 'scheduledMessages';
  static const String settingsBox = 'settings';

  /// راه‌اندازی Hive و ثبت همه آداپترها
  static Future<void> init() async {
    await Hive.initFlutter();

    // ثبت آداپترهای مدل‌ها (اگر نوشتی)
    // Hive.registerAdapter(ContactModelAdapter());
    // Hive.registerAdapter(TransactionModelAdapter());
    // Hive.registerAdapter(ScheduledMessageAdapter());

    await Future.wait([
      Hive.openBox(contactsBox),
      Hive.openBox(transactionsBox),
      Hive.openBox(scheduledMsgsBox),
      Hive.openBox(settingsBox),
    ]);
  }

  /// ذخیره ساده
  static Future<void> save<T>(String box, String key, T value) =>
      Hive.box(box).put(key, value);

  /// خواندن ساده
  static T? get<T>(String box, String key) => Hive.box(box).get(key);

  /// حذف
  static Future<void> delete(String box, String key) =>
      Hive.box(box).delete(key);

  /// تمام کلیدها
  static List<String> keys(String box) => Hive.box(box).keys.cast<String>().toList();
}''';