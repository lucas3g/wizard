// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';

abstract class ClassEvents {}

class SaveClassEvent extends ClassEvents {
  final Class pClass;

  SaveClassEvent({required this.pClass});
}
