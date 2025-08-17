import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';

final transactionProvider = StateNotifierProvider<TransactionNotifier, List<TransactionModel>>(
    (ref) => TransactionNotifier());

class TransactionNotifier extends StateNotifier<List<TransactionModel>> {
  TransactionNotifier() : super([]) {
    _load();
  }

  static const _boxName = 'transactions';

  Future<void> _load() async {
    final box = Hive.box(_boxName);
    state = box.values.cast<TransactionModel>().toList();
  }

  Future<void> addTransaction(TransactionModel tx) async {
    final box = Hive.box(_boxName);
    await box.put(tx.id, tx);
    state = [...state, tx];
  }

  Future<void> updateTransaction(TransactionModel tx) async {
    final box = Hive.box(_boxName);
    await box.put(tx.id, tx);
    state = [for (final t in state) t.id == tx.id ? tx : t];
  }

  Future<void> deleteTransaction(String id) async {
    final box = Hive.box(_boxName);
    await box.delete(id);
    state = state.where((t) => t.id != id).toList();
  }

  List<TransactionModel> filterByCategory(String category) =>
      state.where((t) => t.category == category).toList();
}