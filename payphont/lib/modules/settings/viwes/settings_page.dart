const String content = '''import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // زبان
          ListTile(
            title: const Text('زبان'),
            trailing: DropdownButton<Locale>(
              value: currentLocale,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(value: Locale('fa'), child: Text('فارسی')),
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('ar'), child: Text('العربية')),
                DropdownMenuItem(value: Locale('fr'), child: Text('Français')),
                DropdownMenuItem(value: Locale('zh'), child: Text('中文')),
              ],
              onChanged: (val) =>
                  ref.read(localeProvider.notifier).change(val!),
            ),
          ),
          // تم
          SwitchListTile(
            title: const Text('تم تاریک'),
            value: currentTheme == ThemeMode.dark,
            onChanged: (val) => ref
                .read(themeProvider.notifier)
                .toggle(val ? ThemeMode.dark : ThemeMode.light),
          ),
          // تغییر PIN
          ListTile(
            title: const Text('تغییر PIN'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.pushNamed(context, '/change_pin'),
          ),
        ],
      ),
    );
  }
}''';