import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 2)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final TransactionType type;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.amount,
    required this.description,
    required this.type,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'amount': amount,
        'description': description,
        'type': type.name,
        'category': category,
        'date': date.toIso8601String(),
      };

  factory TransactionModel.fromMap(Map<String, dynamic> map) =>
      TransactionModel(
        id: map['id'],
        amount: map['amount'],
        description: map['description'],
        type: TransactionType.values.byName(map['type']),
        category: map['category'],
        date: DateTime.parse(map['date']),
      );
}

@HiveType(typeId: 20)
enum TransactionType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}