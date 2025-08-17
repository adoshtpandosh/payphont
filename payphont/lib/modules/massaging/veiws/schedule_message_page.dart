import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/scheduled_message.dart';
import '../providers/scheduled_message_provider.dart';

class ScheduleMessagePage extends ConsumerStatefulWidget {
  const ScheduleMessagePage({super.key});

  @override
  ConsumerState<ScheduleMessagePage> createState() => _ScheduleMessagePageState();
}

class _ScheduleMessagePageState extends ConsumerState<ScheduleMessagePage> {
  final _ctrlPhone = TextEditingController();
  final _ctrlMsg = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _schedule() {
    final msg = ScheduledMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      phone: _ctrlPhone.text,
      message: _ctrlMsg.text,
      scheduledTime: _selectedDate,
    );
    ref.read(scheduledMessageProvider.notifier).add(msg);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('زمان‌بندی پیام')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _ctrlPhone,
              decoration: const InputDecoration(labelText: 'شماره'),
            ),
            TextField(
              controller: _ctrlMsg,
              decoration: const InputDecoration(labelText: 'متن پیام'),
            ),
            ListTile(
              title: Text('زمان: ${_selectedDate.toLocal()}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  setState(() => _selectedDate = picked);
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _schedule,
              icon: const Icon(Icons.send),
              label: const Text('زمان‌بندی'),
            ),
          ],
        ),
      ),
    );
  }
}