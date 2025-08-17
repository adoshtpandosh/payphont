import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:excel/excel.dart';
import '../models/transaction_report.dart';

class ReportExporter {
  static Future<File> exportPdf(List<TransactionReport> list) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.TableHelper.fromTextArray(
          headers: ['مبلغ', 'توضیحات', 'تاریخ', 'دسته‌بندی'],
          data: list.map((e) => [e.amount, e.description, e.date.toString().substring(0, 10), e.category]).toList(),
        ),
      ),
    );
    final f = File('${Directory.systemTemp.path}/report.pdf');
    await f.writeAsBytes(await pdf.save());
    return f;
  }

  static Future<File> exportExcel(List<TransactionReport> list) async {
    final excel = Excel.createExcel();
    final sheet = excel['Sheet1'];
    sheet.appendRow(['مبلغ', 'توضیحات', 'تاریخ', 'دسته‌بندی']);
    for (final e in list) {
      sheet.appendRow([e.amount, e.description, e.date.toIso8601String().substring(0, 10), e.category]);
    }
    final f = File('${Directory.systemTemp.path}/report.xlsx');
    await f.writeAsBytes(excel.encode()!);
    return f;
  }
}