// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_drop_down_button_widget.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/homework_note.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/adapters/homework_adapter.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/events/student_events.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/states/student_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class HomeWorkPage extends StatefulWidget {
  final ClassBloc classBloc;
  final StudentBloc studentBloc;

  const HomeWorkPage({
    Key? key,
    required this.classBloc,
    required this.studentBloc,
  }) : super(key: key);

  @override
  State<HomeWorkPage> createState() => _HomeWorkPageState();
}

class _HomeWorkPageState extends State<HomeWorkPage> {
  final fClass = FocusNode();
  final fNote = FocusNode();

  final notes = [
    {'type': 'O', 'name': 'Ótimo'},
    {'type': 'MB', 'name': 'Muito bom'},
    {'type': 'B', 'name': 'Bom'},
    {'type': 'R', 'name': 'Regular'},
  ];

  late bool visibleList = false;

  late Homework homework;

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    widget.classBloc.add(
      GetClassesByIdTeacher(
        idTeacher: ClassIDTeacher(
          GlobalUser.instance.user!.id.value,
        ),
      ),
    );

    homework = HomeworkAdapter.empty();
  }

  Color makeBackGroundColorListTile(String score) {
    switch (score) {
      case 'O':
        return Colors.green.shade400;
      case 'MB':
        return Colors.blue.shade400;
      case 'B':
        return Colors.orange.shade400;
      case 'R':
        return Colors.red.shade400;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'Note by Homework'),
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
                      homework.homeworkClass.validate().exceptionOrNull(),
                  onChanged: (String? e) {
                    homework.setHomeworkClass(e!);

                    widget.studentBloc.add(
                      GetStudentByClassEvent(
                        classID: IdVO(homework.homeworkClass.value),
                      ),
                    );

                    setState(() {
                      visibleList = true;
                    });
                  },
                  value: homework.homeworkClass.value,
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
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final student = students[index];

                            homework.homeworkNote.add(
                              HomeworkNote(student: student, score: ''),
                            );

                            return Container(
                              decoration: BoxDecoration(
                                  color: makeBackGroundColorListTile(
                                      homework.homeworkNote[index].score.value),
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
                                trailing: SizedBox(
                                  width: 160,
                                  child: MyDropDownButtonWidget(
                                    border: false,
                                    value: homework
                                        .homeworkNote[index].score.value,
                                    hint: 'Select the note',
                                    onChanged: (String? e) {
                                      homework.homeworkNote[index].setNote(e!);
                                      setState(() {});
                                    },
                                    items: notes
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e['type'],
                                            child: Text(e['name']!),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: students.length,
                        ),
                        const SizedBox(height: 20),
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
