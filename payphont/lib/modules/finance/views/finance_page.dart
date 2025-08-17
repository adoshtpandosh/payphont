import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/transaction_provider.dart';
import '../models/transaction_model.dart';

class FinancePage extends ConsumerWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('تراکنش‌ها')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add_transaction'),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (_, i) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text('${transactions[i].amount} تومان'),
            subtitle: Text(transactions[i].description),
            trailing: Chip(
              label: Text(
                transactions[i].type == TransactionType.income ? 'دریافت' : 'پرداخت',
              ),
            ),
          ),
        ),
      ),
    );
  }
}