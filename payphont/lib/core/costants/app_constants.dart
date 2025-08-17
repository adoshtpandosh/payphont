// lib/core/costants/app_constants.dart
class AppConstants {
  /// نام باکس‌ها (برای جلوگیری از اشتباه تاپی)
  static const String contactsBox = 'contacts';
  static const String transactionsBox = 'transactions';
  static const String scheduledMsgsBox = 'scheduledMessages';
  static const String settingsBox = 'settings';

  /// کلیدهای SharedPreferences
  static const String prefPin = 'pin';
  static const String prefLocale = 'locale';
  static const String prefThemeMode = 'theme_mode';

  /// الگوهای Regex
  static final RegExp phoneRegex = RegExp(r'^(09|\+989)\d{9}$');
  static final RegExp amountRegex = RegExp(r'^\d+(\.\d+)?$');

  /// مقادیر پیش‌فرض
  static const String defaultPin = '0000';
  static const String defaultLanguage = 'fa';
}