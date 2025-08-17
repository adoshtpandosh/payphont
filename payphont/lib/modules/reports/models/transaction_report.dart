import 'package:hive/hive.dart';

part 'transaction_report.g.dart';

@HiveType(typeId: 3)
class TransactionReport extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String category;

  TransactionReport({
    required this.id,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'amount': amount,
    'description': description,
    'date': date.toIso8601String(),
    'category': category,
  };
}