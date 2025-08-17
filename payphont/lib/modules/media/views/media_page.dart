const String content = '''import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import '../providers/media_provider.dart';

class MediaPage extends ConsumerWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final files = ref.watch(mediaProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('فایل‌ها')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles(
            allowMultiple: true,
            type: FileType.any,
          );
          if (result != null) {
            ref
                .read(mediaProvider.notifier)
                .addFiles(result.files.map((e) => e.path!).toList());
          }
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: files.length,
        itemBuilder: (_, i) => ListTile(
          leading: const Icon(Icons.insert_drive_file),
          title: Text(files[i].split('/').last),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => ref.read(mediaProvider.notifier).removeFile(files[i]),
          ),
        ),
      ),
    );
  }
}''';