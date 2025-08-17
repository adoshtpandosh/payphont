const String content = '''import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/contact_model.dart';

final contactProvider =
    StateNotifierProvider<ContactNotifier, List<ContactModel>>(
        (ref) => ContactNotifier());

class ContactNotifier extends StateNotifier<List<ContactModel>> {
  ContactNotifier() : super([]) {
    _load();
  }

  static const _boxName = 'contacts';

  Future<void> _load() async {
    final box = Hive.box(_boxName);
    state = box.values.cast<ContactModel>().toList();
  }

  Future<void> addContact({
    required String name,
    required String phone,
    required String category,
  }) async {
    final contact = ContactModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      phone: phone,
      category: category,
    );
    final box = Hive.box(_boxName);
    await box.put(contact.id, contact);
    state = [...state, contact];
  }

  Future<void> updateContact(ContactModel updated) async {
    final box = Hive.box(_boxName);
    await box.put(updated.id, updated);
    state = [
      for (final c in state) c.id == updated.id ? updated : c,
    ];
  }

  Future<void> deleteContact(String id) async {
    final box = Hive.box(_boxName);
    await box.delete(id);
    state = state.where((c) => c.id != id).toList();
  }
}''';