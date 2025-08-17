const String content = '''import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/contact_provider.dart';
import '../widgets/contact_card.dart';

class ContactListPage extends ConsumerWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.contacts)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {/* TODO: صفحه افزودن مخاطب */},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (_, i) => ContactCard(
          contact: contacts[i],
          onEdit: () {/* TODO: صفحه ویرایش */},
          onDelete: () =>
              ref.read(contactProvider.notifier).deleteContact(contacts[i].id),
        ),
      ),
    );
  }
}''';