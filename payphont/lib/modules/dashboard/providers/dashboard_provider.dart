// lib/modules/dashboard/providers/dashboard_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ❌ این دو خط را حذف کن
// import '../../contacts/models/contact_model.dart';
// import '../../finance/models/transaction_model.dart';

class DashboardStats {
  final int contactCount;
  final int transactionCount;

  DashboardStats({required this.contactCount, required this.transactionCount});
}

final dashboardStatsProvider = Provider<DashboardStats>((ref) {
  final contacts = Hive.box('contacts').length;
  final transactions = Hive.box('transactions').length;
  return DashboardStats(contactCount: contacts, transactionCount: transactions);
});