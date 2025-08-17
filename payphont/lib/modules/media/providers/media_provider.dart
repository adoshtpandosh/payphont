const String content = '''import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

final mediaProvider = StateNotifierProvider<MediaNotifier, List<File>>(
    (ref) => MediaNotifier());

class MediaNotifier extends StateNotifier<List<File>> {
  MediaNotifier() : super([]);

  /// افزودن چند فایل انتخابی
  void addFiles(List<String> paths) {
    final files = paths.map((p) => File(p)).toList();
    state = [...state, ...files];
  }

  /// حذف فایل از لیست
  void removeFile(File file) {
    state = state.where((f) => f.path != file.path).toList();
  }

  /// فیلتر بر اساس پسوند
  List<File> filterByExtension(String ext) =>
      state.where((f) => f.path.toLowerCase().endsWith(ext.toLowerCase())).toList();
}''';