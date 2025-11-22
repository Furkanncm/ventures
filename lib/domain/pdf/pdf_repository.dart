import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:ventures/common/utils/constants/string_constants.dart';

class PdfService {
  PdfService._();

  static Future<File> generateAnalysisPdf({
    required String content,
    String title = StringConstants.analysisReportTitle,
  }) async {
    final pdf = pw.Document()
      ..addPage(
        pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return [
              pw.Header(
                level: 0,
                child: pw.Text(
                  title,
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),

              pw.Text(
                '${StringConstants.datePrefix} ${DateTime.now().toString().substring(0, 16)}',
                style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey),
              ),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Paragraph(
                text: content,
                style: const pw.TextStyle(fontSize: 12, lineSpacing: 5),
              ),

              pw.SizedBox(height: 20),
              pw.Footer(
                title: pw.Text(
                  StringConstants.generatedBy,
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey,
                  ),
                ),
              ),
            ];
          },
        ),
      );

    // Dosyayı geçici dizine kaydet
    final output = await getTemporaryDirectory();
    final file = File(
      '${output.path}/analysis_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(await pdf.save());

    return file;
  }
}
