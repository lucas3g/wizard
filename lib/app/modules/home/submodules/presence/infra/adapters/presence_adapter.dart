import 'package:intl/intl.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_check.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/adapters/student_adapter.dart';
import 'package:wizard/app/utils/formatters.dart';

class PresenceAdapter {
  static Presence empty() {
    return Presence(
      id: const IdVO(1),
      presenceClass: -1,
      presenceObs: '',
      presenceHomeWork: '',
      presenceDate: '',
      presenceCheck: [],
    );
  }

  static Presence fromMap(dynamic map) {
    return Presence(
      id: IdVO(map['id']),
      presenceClass: map['id_class'],
      presenceObs: map['obs'] ?? '',
      presenceDate:
          DateFormat('yyyy-MM-dd').parse(map['date']).DiaMesAnoTextField(),
      presenceHomeWork: map['homework'],
      presenceCheck: List.from(map['presence'])
          .map(
            (e) => PresenceCheck(
              id: IdVO(e['id']),
              student: Student(
                id: IdVO(e['id_student']),
                studentName: '',
                studentClass: e['id_class'],
                studentPhoneNumber: '',
                studentParents: '',
              ),
              presencePresent: e['type'],
            ),
          )
          .toList(),
    );
  }

  static Presence fromMapSearch(dynamic map) {
    return Presence(
      id: IdVO(map['id']),
      presenceClass: map['id_class'],
      presenceObs: map['obs'] ?? '',
      presenceDate:
          DateFormat('yyyy-MM-dd').parse(map['date']).DiaMesAnoTextField(),
      presenceHomeWork: map['homework'],
      presenceCheck: List.from(map['presence'])
          .map(
            (e) => PresenceCheck(
              id: IdVO(e['id']),
              student: StudentAdapter.fromMap(e['students']),
              presencePresent: e['type'],
            ),
          )
          .toList(),
    );
  }

  static Map<String, dynamic> toMapUpdate(Presence presence) {
    return {
      'id': presence.id.value,
      'id_class': presence.presenceClass.value,
      'date': DateFormat('dd/MM/yyyy')
          .parse(presence.presenceDate.value)
          .AnoMesDiaSupaBase(),
      'obs': presence.presenceObs.value,
      'homework': presence.presenceHomeWork.value,
    };
  }

  static Map<String, dynamic> toMap(Presence presence) {
    return {
      'id_class': presence.presenceClass.value,
      'date': DateFormat('dd/MM/yyyy')
          .parse(presence.presenceDate.value)
          .AnoMesDiaSupaBase(),
      'obs': presence.presenceObs.value,
      'homework': presence.presenceHomeWork.value,
    };
  }

  static List<Map<String, dynamic>> toMapCheck(Presence presence) {
    return presence.presenceCheck
        .map(
          (e) => {
            'id_presence': presence.id.value,
            'id_student': e.student.id.value,
            'type': e.presencePresent.value,
            'id_class': presence.presenceClass.value,
          },
        )
        .toList();
  }

  static List<Map<String, dynamic>> toMapCheckUpdate(Presence presence) {
    return presence.presenceCheck
        .map(
          (e) => {
            'id': e.id.value,
            'id_presence': presence.id.value,
            'id_student': e.student.id.value,
            'type': e.presencePresent.value,
            'id_class': presence.presenceClass.value,
          },
        )
        .toList();
  }
}
