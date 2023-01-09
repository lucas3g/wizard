import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';

abstract class IPDF {
  Future<bool> generatePDF({required Report report});
}
