import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:convert';
import '../providers/report_provider.dart';

class ReportPage extends ConsumerWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final reports = ref.watch(reportProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('گزارش‌ها')),
      body: Column(
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.file_download),
            label: const Text('خروجی JSON'),
            onPressed: () {
              final json = jsonEncode(reports.map((e) => e.toMap()).toList());
              Share.share(json);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reports.length,
              itemBuilder: (_, i) => ListTile(
                title: Text('${reports[i].amount} تومان'),
                subtitle: Text(reports[i].description),
              ),
            ),
          ),
        ],
      ),
    );
  }
}