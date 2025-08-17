const String content = '''import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:payphont/modules/contacts/providers/contact_provider.dart';

void main() {
  test('افزودن مخاطب', () {
    final container = ProviderContainer();
    container.read(contactProvider.notifier).addContact('Ali', '09123456789', 'مشتری');
    final list = container.read(contactProvider);
    expect(list.length, 1);
    expect(list.first.name, 'Ali');
  });
}''';