// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_drop_down_button_widget.dart';
import 'package:wizard/app/components/my_elevated_button_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/events/homework_events.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/homework_bloc.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/states/homework_states.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/events/presence_events.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/presence_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/states/presence_states.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/vos/report_student.dart';
import 'package:wizard/app/modules/home/submodules/report/infra/adapters/report_adapter.dart';
import 'package:wizard/app/modules/home/submodules/report/presenter/bloc/events/report_events.dart';
import 'package:wizard/app/modules/home/submodules/report/presenter/bloc/report_bloc.dart';
import 'package:wizard/app/modules/home/submodules/report/presenter/bloc/states/report_states.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/events/review_events.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/review_bloc.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/states/review_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/events/student_events.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/states/student_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class ReportPage extends StatefulWidget {
  final ClassBloc classBloc;
  final StudentBloc studentBloc;
  final ReportBloc reportBloc;
  final PresenceBloc presenceBloc;
  final HomeworkBloc homeworkBloc;
  final ReviewBloc reviewBloc;

  const ReportPage({
    Key? key,
    required this.classBloc,
    required this.studentBloc,
    required this.reportBloc,
    required this.presenceBloc,
    required this.homeworkBloc,
    required this.reviewBloc,
  }) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final fClass = FocusNode();
  late Report report;

  late bool visibleButton = false;
  late int dropDownValue = -1;

  late StreamSubscription sub;
  late StreamSubscription subPresence;
  late StreamSubscription subReport;
  late StreamSubscription subHomework;
  late StreamSubscription subReview;

  @override
  void initState() {
    super.initState();

    widget.classBloc.add(
      GetClassesByIdTeacher(
        idTeacher: ClassIDTeacher(
          GlobalUser.instance.user.id.value,
        ),
      ),
    );

    report = ReportAdapter.empty();

    sub = widget.studentBloc.stream.listen((state) {
      if (state is SuccessGetStudentByClass) {
        report.students.clear();

        for (var student in state.students) {
          report.students.add(
            ReportStudent(
              codStudent: state.students.indexOf(student) + 1,
              idStudent: student.id.value,
              studentName: student.studentName.value,
            ),
          );
        }
      }

      if (state is ErrorStudent) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }
    });

    subPresence = widget.presenceBloc.stream.listen((state) {
      if (state is SuccessGetPresenceByClass) {
        report.presences.clear();

        for (var presence in state.presences) {
          report.presences.add(presence);
        }
      }

      if (state is ErrorPresence) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }
    });

    subHomework = widget.homeworkBloc.stream.listen((state) {
      if (state is SuccessGetHomeworksByClass) {
        report.homeworks.clear();

        for (var homework in state.homeworks) {
          report.homeworks.add(homework);
        }
      }

      if (state is ErrorSaveHomework) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }
    });

    subReport = widget.reportBloc.stream.listen((state) {
      if (state is SuccessGenerateReport) {
        MySnackBar(
          message: 'PDF generated successfully ',
          type: TypeSnackBar.success,
        );
      }

      if (state is ErrorGenerateReport) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }
    });

    subReview = widget.reviewBloc.stream.listen((state) {
      if (state is SuccessGetReviewsByClass) {
        report.reviews.clear();

        for (var review in state.reviews) {
          report.reviews.add(review);
        }
      }

      if (state is ErrorSaveReview) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();
    subPresence.cancel();
    subReport.cancel();
    subHomework.cancel();
    subReview.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'General Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            BlocBuilder<ClassBloc, ClassStates>(
              bloc: widget.classBloc,
              builder: (context, state) {
                if (state is! SuccessGetListClass) {
                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.colors.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                final classes = state.classes;

                return MyDropDownButtonWidget(
                  focusNode: fClass,
                  hint: 'Select a class',
                  validator: (v) =>
                      report.reportClass.validate().exceptionOrNull(),
                  onChanged: (dynamic e) {
                    final pClass = classes.firstWhere((v) => v.id.value == e);

                    report.reportClass = Class(
                      id: IdVO(e!),
                      name: pClass.name.value,
                      dayWeek: pClass.dayWeek.value,
                      schedule: pClass.schedule.value,
                      idTeacher: pClass.idTeacher.value,
                    );

                    setState(() {
                      visibleButton = true;
                      dropDownValue = e;
                    });

                    widget.studentBloc.add(
                      GetStudentByClassEvent(
                        classID: IdVO(e),
                      ),
                    );

                    widget.presenceBloc.add(
                      GetPresenceByClassEvent(
                        pClass: e,
                      ),
                    );

                    widget.homeworkBloc.add(
                      GetHomeworksByClassEvent(
                        classID: e,
                      ),
                    );

                    widget.reviewBloc.add(
                      GetReviewsByClassEvent(
                        classID: e,
                      ),
                    );
                  },
                  value: dropDownValue,
                  items: classes
                      .map(
                        (e) => DropdownMenuItem(
                          value: e.id.value,
                          child: Text(e.name.value),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const Divider(),
            Visibility(
              visible: visibleButton,
              child: MyInputWidget(
                label: 'Observation',
                hintText: 'Type a observation',
                value: report.obs.value,
                onChanged: (e) => report.setObs(e),
              ),
            ),
            const Divider(),
            Visibility(
              visible: visibleButton,
              child: Row(
                children: [
                  Expanded(
                    child: BlocBuilder<ReportBloc, ReportStates>(
                        bloc: widget.reportBloc,
                        builder: (context, state) {
                          return MyElevatedButtonWidget(
                            label: state is LoadingReport
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text('Generate Report'),
                            icon: Icons.newspaper_rounded,
                            onPressed: () async {
                              widget.reportBloc.add(
                                GenerateReportPDFEvent(report: report),
                              );
                            },
                          );
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
