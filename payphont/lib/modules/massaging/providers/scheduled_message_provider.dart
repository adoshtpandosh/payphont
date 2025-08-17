import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/scheduled_message.dart';

final scheduledMessageProvider = StateNotifierProvider<ScheduledMessageNotifier, List<ScheduledMessage>>(
    (ref) => ScheduledMessageNotifier());

class ScheduledMessageNotifier extends StateNotifier<List<ScheduledMessage>> {
  ScheduledMessageNotifier() : super([]) {
    _load();
  }

  static const _boxName = 'scheduledMessages';

  Future<void> _load() async {
    final box = Hive.box(_boxName);
    state = box.values.cast<ScheduledMessage>().toList();
  }

  Future<void> add(ScheduledMessage msg) async {
    final box = Hive.box(_boxName);
    await box.put(msg.id, msg);
    state = [...state, msg];
  }

  Future<void> remove(String id) async {
    final box = Hive.box(_boxName);
    await box.delete(id);
    state = state.where((m) => m.id != id).toList();
  }

  Future<void> update(ScheduledMessage msg) async {
    final box = Hive.box(_boxName);
    await box.put(msg.id, msg);
    state = [for (final m in state) m.id == msg.id ? msg : m];
  }
}