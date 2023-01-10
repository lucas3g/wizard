import 'dart:io';
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_check.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/vos/report_student.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class PDFController {
  static String returnsMissing(
      List<PresenceCheck> checks, List<ReportStudent> students) {
    late String missing = '';
    for (var check in checks) {
      if (check.presencePresent.value == 'Absent') {
        final codStudent = students
            .where((student) => student.idStudent == check.studentID.value)
            .first
            .codStudent;
        missing += '$codStudent, ';
      }
    }

    if (missing.isNotEmpty) {
      return missing.substring(0, missing.length - 2);
    }

    return missing;
  }

  static Future sharePDF(File pdf) async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));

      TypedData fileByte;
      late String path;

      fileByte = await File(pdf.path).readAsBytes();
      path = pdf.path;

      File(path).writeAsBytesSync(fileByte.buffer.asUint8List());

      await Share.shareFiles([path]);
    } catch (e) {
      MySnackBar(message: e.toString(), type: TypeSnackBar.error);
    }
  }

  static String translateDay(String day) {
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
}
