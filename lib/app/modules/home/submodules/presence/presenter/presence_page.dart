// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_drop_down_button_widget.dart';
import 'package:wizard/app/components/my_elevated_button_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_check.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/adapters/presence_adapter.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/events/presence_events.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/presence_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/states/presence_states.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/events/student_events.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/states/student_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class PresencePage extends StatefulWidget {
  final ClassBloc classBloc;
  final StudentBloc studentBloc;
  final PresenceBloc presenceBloc;

  const PresencePage({
    Key? key,
    required this.classBloc,
    required this.studentBloc,
    required this.presenceBloc,
  }) : super(key: key);

  @override
  State<PresencePage> createState() => _PresencePageState();
}

class _PresencePageState extends State<PresencePage> {
  final fClass = FocusNode();
  final fObs = FocusNode();
  final fHomework = FocusNode();
  final fDate = FocusNode();

  late bool visibleList = false;

  late Presence presence;

  late StreamSubscription sub;
  late StreamSubscription subPresence;

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

    presence = PresenceAdapter.empty();

    sub = widget.studentBloc.stream.listen((state) {
      if (state is SuccessGetStudentByClass) {
        presence.presenceCheck!.clear();

        for (var student in state.students) {
          presence.presenceCheck!.add(
            PresenceCheck(
              studentID: student.id.value,
              presencePresent: 'Absent',
            ),
          );
        }
      }
    });

    subPresence = widget.presenceBloc.stream.listen((state) async {
      if (state is ErrorPresence) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }

      if (state is SuccessSavePresence) {
        MySnackBar(
          message: 'Presence save with success',
          type: TypeSnackBar.success,
        );
        await Future.delayed(const Duration(milliseconds: 300));
        Modular.to.pop();
      }
    });
  }

  void setPresence(Student student) {
    if (presence.presenceCheck!
            .where((e) => e.studentID.value == student.id.value)
            .first
            .presencePresent
            .value ==
        'Present') {
      presence.presenceCheck!
          .where((e) => e.studentID.value == student.id.value)
          .first
          .setPresencePresent('Absent');
    } else {
      presence.presenceCheck!
          .where((e) => e.studentID.value == student.id.value)
          .first
          .setPresencePresent('Present');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'Mark Presence'),
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
                      presence.presenceClass.validate().exceptionOrNull(),
                  onChanged: (String? e) {
                    presence.setPresenceClass(e!);

                    widget.studentBloc.add(
                      GetStudentByClassEvent(
                        classID: IdVO(presence.presenceClass.value),
                      ),
                    );

                    setState(() {
                      visibleList = true;
                    });
                  },
                  value: presence.presenceClass.value,
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
            Visibility(visible: visibleList, child: const SizedBox(height: 15)),
            Visibility(
              visible: visibleList,
              child: MyInputWidget(
                keyboardType: TextInputType.number,
                focusNode: fHomework,
                label: 'Homework Number',
                validator: (v) =>
                    presence.presenceHomeWork.validate().exceptionOrNull(),
                value: presence.presenceHomeWork.value,
                onChanged: (e) => presence.setPresenceHomeWork(e),
                inputFormaters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            Visibility(visible: visibleList, child: const SizedBox(height: 10)),
            Visibility(
              visible: visibleList,
              child: MyInputWidget(
                focusNode: fDate,
                hintText: 'Enter the date of presence',
                label: 'Date',
                onChanged: presence.setPresenceDate,
                validator: (v) =>
                    presence.presenceDate.validate().exceptionOrNull(),
                value: presence.presenceDate.value,
                keyboardType: TextInputType.number,
                inputFormaters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
              ),
            ),
            Visibility(visible: visibleList, child: const SizedBox(height: 10)),
            Visibility(
              visible: visibleList,
              child: MyInputWidget(
                focusNode: fObs,
                label: 'Observation',
                validator: (v) =>
                    presence.presenceObs.validate().exceptionOrNull(),
                value: presence.presenceObs.value,
                onChanged: (e) => presence.setPresenceObs(e),
                inputFormaters: [UpperCaseTextFormatter()],
              ),
            ),
            const Divider(),
            Visibility(
              visible: visibleList,
              child: BlocBuilder<StudentBloc, StudentStates>(
                bloc: widget.studentBloc,
                builder: (context, state) {
                  if (state is! SuccessGetStudentByClass) {
                    return const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final students = state.students;

                  if (students.isEmpty) {
                    return const Text('Students list empty');
                  }

                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final student = students[index];

                              return Container(
                                decoration: BoxDecoration(
                                    color: presence.presenceCheck!
                                                .where((e) =>
                                                    e.studentID.value ==
                                                    student.id.value)
                                                .first
                                                .presencePresent
                                                .value ==
                                            'Absent'
                                        ? Colors.red.shade400
                                        : Colors.green.shade400,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(0, 8),
                                      )
                                    ]),
                                child: ListTile(
                                  title: Text(student.studentName.value),
                                  onTap: () {
                                    setPresence(student);
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            itemCount: students.length,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<PresenceBloc, PresenceStates>(
                                bloc: widget.presenceBloc,
                                builder: (context, state) {
                                  return MyElevatedButtonWidget(
                                    label: state is LoadingPresence
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text('Save'),
                                    icon: Icons.save_rounded,
                                    onPressed: () {
                                      widget.presenceBloc.add(
                                        SavePresenceEvent(presence: presence),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
