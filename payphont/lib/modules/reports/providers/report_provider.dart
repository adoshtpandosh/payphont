import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_report.dart';
import '../../finance/models/transaction_model.dart';

final reportProvider = StateNotifierProvider<ReportNotifier, List<TransactionReport>>(
    (ref) => ReportNotifier());

class ReportNotifier extends StateNotifier<List<TransactionReport>> {
  ReportNotifier() : super([]);

  static const _boxName = 'transactions';

  /// بارگذاری همه تراکنش‌ها و تبدیل به مدل Report
  Future<void> _loadAll() async {
    final box = Hive.box(_boxName);
    final txList = box.values.cast<TransactionModel>().toList();
    state = txList.map((tx) => TransactionReport(
          id: tx.id,
          amount: tx.amount,
          description: tx.description,
          date: tx.date,
          category: tx.category,
        )).toList();
  }

  /// فیلتر بر اساس بازه زمانی و دسته‌بندی
  void filter({
    DateTime? from,
    DateTime? to,
    String? category,
  }) {
    final box = Hive.box(_boxName);
    final txList = box.values.cast<TransactionModel>().toList();

    var result = txList.map((tx) => TransactionReport(
          id: tx.id,
          amount: tx.amount,
          description: tx.description,
          date: tx.date,
          category: tx.category,
        ));

    if (from != null) {
      result = result.where((r) => r.date.isAfter(from.subtract(const Duration(days: 1))));
    }
    if (to != null) {
      result = result.where((r) => r.date.isBefore(to.add(const Duration(days: 1))));
    }
    if (category != null && category.isNotEmpty) {
      result = result.where((r) => r.category == category);
    }

    state = result.toList();
  }

  /// بازنشانی به حالت بدون فیلتر
  void reset() => _loadAll();
}