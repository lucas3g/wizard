// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/report/presenter/bloc/events/report_events.dart';

import 'package:wizard/app/shared/components/my_app_bar_widget.dart';
import 'package:wizard/app/shared/components/my_drop_down_button_widget.dart';
import 'package:wizard/app/shared/components/my_elevated_button_widget.dart';
import 'package:wizard/app/shared/components/my_input_widget.dart';
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
import 'package:wizard/app/modules/home/submodules/report/presenter/bloc/report_bloc.dart';
import 'package:wizard/app/modules/home/submodules/report/presenter/bloc/states/report_states.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/events/review_events.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/review_bloc.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/states/review_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/events/student_events.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/states/student_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';
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
  final gkForm = GlobalKey<FormState>();

  final dateStartController = TextEditingController();
  final dateEndController = TextEditingController();

  final fClass = FocusNode();
  final fDateStart = FocusNode();
  final fDateEnd = FocusNode();

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
      if (state is SuccessGetPresenceByClassAndDate) {
        report.presences.clear();

        for (var presence in state.presences) {
          report.presences.add(presence);
        }
      }

      // if (state is ErrorPresence) {
      //   MySnackBar(message: state.message, type: TypeSnackBar.error);
      // }
    });

    subHomework = widget.homeworkBloc.stream.listen((state) {
      if (state is SuccessGetHomeworksByClassAndDate) {
        report.homeworks.clear();

        for (var homework in state.homeworks) {
          report.homeworks.add(homework);
        }
      }

      // if (state is ErrorHomework) {
      //   MySnackBar(message: state.message, type: TypeSnackBar.error);
      // }
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
      if (state is SuccessGetReviewsByClassAndDate) {
        report.reviews.clear();

        for (var review in state.reviews) {
          report.reviews.add(review);
        }
      }

      // if (state is ErrorReview) {
      //   MySnackBar(message: state.message, type: TypeSnackBar.error);
      // }
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

  void searchData() {
    if (dateStartController.text.isNotEmpty &&
        dateEndController.text.isNotEmpty) {
      report.presences.clear();
      report.homeworks.clear();
      report.reviews.clear();

      widget.presenceBloc.add(
        GetPresenceByClassAndDateEvent(
          pClass: report.reportClass.id.value,
          dates: DatesEntity(
            dateStart: dateStartController.text,
            dateEnd: dateEndController.text,
          ),
        ),
      );

      widget.homeworkBloc.add(
        GetHomeworksByClassAndDateEvent(
          classID: report.reportClass.id.value,
          dates: DatesEntity(
            dateStart: dateStartController.text,
            dateEnd: dateEndController.text,
          ),
        ),
      );

      widget.reviewBloc.add(
        GetReviewsByClassAndDateEvent(
          classID: report.reportClass.id.value,
          dates: DatesEntity(
            dateStart: dateStartController.text,
            dateEnd: dateEndController.text,
          ),
        ),
      );
    }
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
        child: Form(
          key: gkForm,
          child: Column(
            children: [
              BlocBuilder<ClassBloc, ClassStates>(
                bloc: widget.classBloc,
                builder: (context, state) {
                  if (state is! SuccessGetListClass) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(),
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
                        id: IdVO(e),
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
                          classID: report.reportClass.id.value,
                        ),
                      );
                    },
                    value: dropDownValue,
                    items: classes
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.id.value,
                            child: Text(
                                '${e.name.value} / ${e.dayWeek.value} / ${e.schedule.value}'),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              Visibility(
                  visible: visibleButton, child: const SizedBox(height: 10)),
              Visibility(
                visible: visibleButton,
                child: MyInputWidget(
                  controller: dateStartController,
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                    );

                    if (selectedDate != null) {
                      report.setDateStart(selectedDate.DiaMesAnoTextField());

                      dateStartController.text = report.dateStart.value;

                      searchData();
                    }
                  },
                  label: 'Date Start',
                  hintText: 'Type a date Start',
                  onChanged: report.setDateStart,
                  validator: (v) =>
                      report.dateStart.validate().exceptionOrNull(),
                ),
              ),
              Visibility(
                  visible: visibleButton, child: const SizedBox(height: 10)),
              Visibility(
                visible: visibleButton,
                child: MyInputWidget(
                  controller: dateEndController,
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365),
                      ),
                    );

                    if (selectedDate != null) {
                      report.setDateEnd(selectedDate.DiaMesAnoTextField());

                      dateEndController.text = report.dateEnd.value;

                      searchData();
                    }
                  },
                  label: 'Date End',
                  hintText: 'Type a date End',
                  onChanged: report.setDateEnd,
                  validator: (v) => report.dateEnd.validate().exceptionOrNull(),
                ),
              ),
              Visibility(
                visible: visibleButton,
                child: const SizedBox(height: 10),
              ),
              Visibility(
                visible: visibleButton,
                child: MyInputWidget(
                  label: 'Observation',
                  hintText: 'Type a observation',
                  value: report.obs.value,
                  onChanged: (e) => report.setObs(e),
                ),
              ),
              Visibility(visible: visibleButton, child: const Divider()),
              Visibility(
                visible: visibleButton,
                child: BlocBuilder<ReportBloc, ReportStates>(
                    bloc: widget.reportBloc,
                    builder: (context, state) {
                      return Row(
                        children: [
                          Expanded(
                            child: MyElevatedButtonWidget(
                              label: state is LoadingReport
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Generate Report'),
                              icon: Icons.newspaper_rounded,
                              onPressed: () {
                                if (!gkForm.currentState!.validate()) {
                                  return;
                                }

                                widget.reportBloc.add(
                                  GenerateReportPDFEvent(report: report),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
