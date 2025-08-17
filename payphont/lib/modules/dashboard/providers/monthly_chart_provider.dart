// lib/modules/dashboard/providers/monthly_chart_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../finance/models/transaction_model.dart';

final monthlyChartProvider = Provider<Map<int, double>>((ref) {
  final box = Hive.box('transactions');
  final txList = box.values.cast<TransactionModel>().toList();

  final map = <int, double>{};
  for (final tx in txList) {
    final month = tx.date.month;
    map[month] = (map[month] ?? 0) + tx.amount;
  }
  return map;
});