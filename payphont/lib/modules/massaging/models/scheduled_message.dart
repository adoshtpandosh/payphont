import 'package:hive/hive.dart';

part 'scheduled_message.g.dart';

@HiveType(typeId: 3)
class ScheduledMessage extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String phone;

  @HiveField(2)
  final String message;

  @HiveField(3)
  final DateTime scheduledTime;

  @HiveField(4)
  final bool isSent;

  ScheduledMessage({
    required this.id,
    required this.phone,
    required this.message,
    required this.scheduledTime,
    this.isSent = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'phone': phone,
    'message': message,
    'scheduledTime': scheduledTime.toIso8601String(),
    'isSent': isSent,
  };

  factory ScheduledMessage.fromMap(Map<String, dynamic> map) =>
      ScheduledMessage(
        id: map['id'],
        phone: map['phone'],
        message: map['message'],
        scheduledTime: DateTime.parse(map['scheduledTime']),
        isSent: map['isSent'] ?? false,
      );
}