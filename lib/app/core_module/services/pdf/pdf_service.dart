import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/services/pdf/pdf_interface.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_check.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:wizard/app/modules/home/submodules/report/domain/vos/report_student.dart';
import 'package:wizard/app/utils/my_snackbar.dart';
import 'package:printing/printing.dart';

final labelReporth1 = pw.TextStyle(
  fontSize: 14,
  color: PdfColors.black,
  fontWeight: pw.FontWeight.bold,
);

final labelReporth2 = pw.TextStyle(
  fontSize: 12,
  color: PdfColors.black,
  fontWeight: pw.FontWeight.bold,
);

final logoWizardH1 = pw.TextStyle(
  fontSize: 28,
  color: PdfColor.fromHex('002C4D'),
  fontWeight: pw.FontWeight.bold,
);

final logoWizardH2 = pw.TextStyle(
  fontSize: 14,
  color: PdfColor.fromHex('002C4D'),
);

String returnsMissing(
    List<PresenceCheck> checks, List<ReportStudent> students) {
  late String missing = '';
  for (var check in checks) {
    if (check.presencePresent.value == 'Absent') {
      for (var student in students) {
        if (student.idStudent == check.studentID.value) {
          missing += '${student.codStudent}, ';
        }
      }
    }
  }

  if (missing.isNotEmpty) {
    return missing.substring(0, missing.length - 2);
  }

  return missing;
}

Future sharePDF(File pdf) async {
  try {
    await Future.delayed(const Duration(milliseconds: 500));

    TypedData audioByte;
    late String path;

    audioByte = await File(pdf.path).readAsBytes();
    path = pdf.path;

    File(path).writeAsBytesSync(audioByte.buffer.asUint8List());

    await Share.shareFiles([path]);
  } catch (e) {
    MySnackBar(message: e.toString(), type: TypeSnackBar.error);
  }
}

String translateDay(String day) {
  switch (day) {
    case 'Monday':
      return 'Segunda-Feira';
    case 'Tuesday':
      return 'Terça-Feira';
    case 'Wednesday':
      return 'Quarta-Feira';
    case 'Thurday':
      return 'Quinta-Feira';
    case 'Friday':
      return 'Sexta-Feira';
    case 'Sartuday':
      return 'Sábado';
    default:
      return 'Domingo';
  }
}

class PDFService implements IPDF {
  @override
  Future<bool> generatePDF({required Report report}) async {
    try {
      final pdf = pw.Document();

      final image = await networkImage(
          'https://i0.wp.com/wizardrecreio.com.br/wp-content/uploads/2017/01/LOGO-NOVA-TRANSPARENTE.png?fit=671%2C223');

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Image(image, width: 150),
                  // pw.Text('Wizard', style: logoWizardH1),
                  // pw.Text('by Pearson', style: logoWizardH2),
                  pw.SizedBox(height: 15),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'Turma: ',
                              style: labelReporth2,
                            ),
                            pw.TextSpan(text: report.reportClass.name.value)
                          ],
                        ),
                      ),
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'Modalidade: ',
                              style: labelReporth2,
                            ),
                            const pw.TextSpan(text: '_____________')
                          ],
                        ),
                      ),
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'Ano: ',
                              style: labelReporth2,
                            ),
                            pw.TextSpan(text: '${DateTime.now().year}')
                          ],
                        ),
                      ),
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'Professor: ',
                              style: labelReporth2,
                            ),
                            pw.TextSpan(
                                text: GlobalUser.instance.user.name.value)
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 5),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'Dia da Semana: ',
                              style: labelReporth2,
                            ),
                            pw.TextSpan(
                              text: translateDay(
                                report.reportClass.dayWeek.value,
                              ),
                            )
                          ],
                        ),
                      ),
                      pw.RichText(
                        text: pw.TextSpan(
                          children: [
                            pw.TextSpan(
                              text: 'Horário: ',
                              style: labelReporth2,
                            ),
                            pw.TextSpan(text: report.reportClass.schedule.value)
                          ],
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Alunos:',
                    style: labelReporth1,
                  ),
                  pw.SizedBox(height: 10),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: report.students
                        .map(
                          (student) => pw.Container(
                            width: 300,
                            height: 20,
                            padding: const pw.EdgeInsets.only(
                              top: 20,
                              left: 10,
                              right: 10,
                              bottom: 17,
                            ),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                            ),
                            child: pw.Text(
                              '${student.codStudent} - ${student.studentName.value}',
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Table(border: pw.TableBorder.all(), children: [
                    pw.TableRow(
                      children: [
                        pw.Text(
                          '  Lição',
                          style: labelReporth1,
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          '  Data',
                          style: labelReporth1,
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          '  Faltantes',
                          style: labelReporth1,
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          '  Observações',
                          style: labelReporth1,
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ),
                    for (int i = 0; i < report.presences.length; i++) ...[
                      pw.TableRow(
                        children: [
                          pw.Text(
                            report.presences[i].presenceHomeWork.value,
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            report.presences[i].presenceDate.value,
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            returnsMissing(
                              report.presences[i].presenceCheck!,
                              report.students,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            report.presences[i].presenceObs.value,
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      )
                    ]
                  ]),
                ]);
          },
        ),
      );

      final output = await getExternalStorageDirectory();
      final file = File("${output!.path}/resumoWizUp.pdf");
      await file.writeAsBytes(await pdf.save());

      await sharePDF(file);

      return true;
    } catch (e) {
      MySnackBar(message: e.toString(), type: TypeSnackBar.error);
      return false;
    }
  }
}
