const String content = '''import 'package:flutter/material.dart';

Future<List<String>?> showFilterSheet(BuildContext context,
    {required List<String> categories}) async {
  final selected = <String>{};
  return await showModalBottomSheet<List<String>>(
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) => Column(
          children: [
            Expanded(
              child: ListView(
                children: categories
                    .map((e) => CheckboxListTile(
                          title: Text(e),
                          value: selected.contains(e),
                          onChanged: (v) => setState(() => v!
                              ? selected.add(e)
                              : selected.remove(e)),
                        ))
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, selected.toList()),
              child: const Text('اعمال'),
            ),
          ],
        ),
      );
    },
  );
}''';