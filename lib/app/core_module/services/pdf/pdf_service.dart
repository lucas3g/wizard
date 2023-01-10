import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/services/pdf/controller/pdf_controller.dart';
import 'package:wizard/app/core_module/services/pdf/pdf_interface.dart';
import 'package:wizard/app/core_module/services/pdf/styles/pdf_styles.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:wizard/app/utils/my_snackbar.dart';
import 'package:printing/printing.dart';

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
          margin: const pw.EdgeInsets.all(40),
          build: (pw.Context context) {
            return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Image(image, width: 150),
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
                              text: PDFController.translateDay(
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
                            PDFController.returnsMissing(
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

      pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(40),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Notas', style: labelReporth1),
                pw.SizedBox(height: 10),
                pw.Text('Alunos',
                    style: labelReporth1, textAlign: pw.TextAlign.center),
                pw.SizedBox(height: 10),
                pw.Row(children: [
                  pw.Container(
                    width: 50,
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Text(
                      'Lição',
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                  pw.ListView.builder(
                    direction: pw.Axis.horizontal,
                    itemBuilder: (context, index) {
                      return pw.Row(children: [
                        pw.ListView.builder(
                          direction: pw.Axis.horizontal,
                          itemBuilder: (context, index2) {
                            return pw.Container(
                              width: 30,
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Text(
                                (index2 + 1).toString(),
                                textAlign: pw.TextAlign.center,
                              ),
                            );
                          },
                          itemCount: report.homeworks.first.homeworkNote.length,
                        ),
                      ]);
                    },
                    itemCount: 1,
                  ),
                ]),
                pw.Container(
                  child: pw.Wrap(children: [
                    pw.ListView.builder(
                      direction: pw.Axis.horizontal,
                      itemBuilder: (context, index) {
                        return pw.Row(children: [
                          pw.Container(
                            width: 50,
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Text(
                              report.homeworks[index].homeworkName.value,
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                          pw.ListView.builder(
                            direction: pw.Axis.horizontal,
                            itemBuilder: (context, index2) {
                              return pw.Container(
                                width: 30,
                                decoration:
                                    pw.BoxDecoration(border: pw.Border.all()),
                                child: pw.Text(
                                  report.homeworks[index].homeworkNote[index2]
                                      .score.value,
                                  textAlign: pw.TextAlign.center,
                                ),
                              );
                            },
                            itemCount:
                                report.homeworks[index].homeworkNote.length,
                          ),
                        ]);
                      },
                      itemCount: report.homeworks.length,
                    ),
                  ]),
                ),
              ],
            );
          }));

      final output = await getExternalStorageDirectory();
      final file = File("${output!.path}/resumoWizUp.pdf");
      await file.writeAsBytes(await pdf.save());

      await PDFController.sharePDF(file);

      return true;
    } catch (e) {
      MySnackBar(message: e.toString(), type: TypeSnackBar.error);
      return false;
    }
  }
}
