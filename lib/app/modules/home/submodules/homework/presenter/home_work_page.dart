// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/services/themeMode/theme_mode_controller.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/vos/homework_note.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/adapters/homework_adapter.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/events/homework_events.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/homework_bloc.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/states/homework_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/events/student_events.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/states/student_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/shared/components/my_app_bar_widget.dart';
import 'package:wizard/app/shared/components/my_drop_down_button_widget.dart';
import 'package:wizard/app/shared/components/my_elevated_button_widget.dart';
import 'package:wizard/app/shared/components/my_input_widget.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class HomeWorkPage extends StatefulWidget {
  final ClassBloc classBloc;
  final StudentBloc studentBloc;
  final HomeworkBloc homeworkBloc;

  const HomeWorkPage({
    Key? key,
    required this.classBloc,
    required this.studentBloc,
    required this.homeworkBloc,
  }) : super(key: key);

  @override
  State<HomeWorkPage> createState() => _HomeWorkPageState();
}

class _HomeWorkPageState extends State<HomeWorkPage> {
  final dataController = TextEditingController();

  final fClass = FocusNode();
  final fNumber = FocusNode();
  final fDate = FocusNode();

  late bool visibleList = false;

  late Homework homework;

  late StreamSubscription sub;
  late StreamSubscription subHome;

  final gkForm = GlobalKey<FormState>();
  final gkFormNotes = GlobalKey<FormState>();

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

    sub = widget.studentBloc.stream.listen((state) {
      if (state is SuccessGetStudentByClass) {
        homework.homeworkNote.clear();

        for (var student in state.students) {
          homework.homeworkNote.add(
            HomeworkNote(
              id: const IdVO(-1),
              student: student,
              score: '',
            ),
          );
        }
      }

      if (state is ErrorStudent) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }
    });

    subHome = widget.homeworkBloc.stream.listen((state) async {
      if (state is SuccessSaveHomework) {
        MySnackBar(
          message: 'Homework save with success',
          type: TypeSnackBar.success,
        );
        await Future.delayed(const Duration(milliseconds: 300));
        Modular.to.pop();
      }

      if (state is ErrorHomework) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }
    });

    homework = HomeworkAdapter.empty();
  }

  @override
  void dispose() {
    sub.cancel();
    subHome.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'Note by Homework'),
      ),
      body: Form(
        key: gkForm,
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: ListView(
            shrinkWrap: true,
            children: [
              StreamBuilder<ClassStates>(
                stream: widget.classBloc.stream,
                builder: (context, state) {
                  if (state.data is! SuccessGetListClass) {
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

                  final classes = (state.data as SuccessGetListClass).classes;

                  return MyDropDownButtonWidget(
                    focusNode: fClass,
                    hint: 'Select a class',
                    validator: (v) =>
                        homework.homeworkClass.validate().exceptionOrNull(),
                    onChanged: (dynamic e) {
                      homework.setHomeworkClass(e);

                      widget.studentBloc.add(
                        GetStudentByClassEvent(
                          classID: homework.homeworkClass.value,
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
                            child: Text(
                                '${e.name.value} / ${e.dayWeek.value} / ${e.schedule.value}'),
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
                      return const Center(
                        child: Text('Students list empty'),
                      );
                    }

                    return Column(
                      children: [
                        MyInputWidget(
                          focusNode: fNumber,
                          hintText: 'Enter the number of the homework',
                          label: 'Number',
                          onChanged: homework.setHomeworkName,
                          validator: (v) => homework.homeworkName
                              .validate()
                              .exceptionOrNull(),
                          value: homework.homeworkName.value,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        MyInputWidget(
                          controller: dataController,
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
                              homework.setHomeworkData(
                                  selectedDate.DiaMesAnoTextField());

                              dataController.text = homework.homeworkData.value;
                            }
                          },
                          focusNode: fDate,
                          hintText: 'Enter the date of homework',
                          label: 'Date',
                          validator: (v) => homework.homeworkData
                              .validate()
                              .exceptionOrNull(),
                          readOnly: true,
                        ),
                        const SizedBox(height: 15),
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final student = students[index];

                            return Container(
                              decoration: BoxDecoration(
                                color: makeBackGroundColorListTile(
                                  homework.homeworkNote[index].score.value,
                                  context,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: homework.homeworkNote[index].score
                                          .value.isNotEmpty
                                      ? makeBackGroundColorListTile(
                                          homework
                                              .homeworkNote[index].score.value,
                                          context,
                                        )
                                      : ThemeModeController.themeMode ==
                                              ThemeMode.dark
                                          ? context.myTheme.onPrimary
                                          : context.myTheme.onPrimaryContainer,
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  student.studentName.value,
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        ThemeModeController.themeMode ==
                                                ThemeMode.dark
                                            ? const Shadow(
                                                blurRadius: 10,
                                                offset: Offset(0, 1),
                                              )
                                            : const Shadow(),
                                      ]),
                                ),
                                trailing: SizedBox(
                                  width: 160,
                                  child: MyDropDownButtonWidget(
                                    border: false,
                                    validator: (v) => homework
                                        .homeworkNote[index].score
                                        .validate()
                                        .exceptionOrNull(),
                                    value: homework
                                        .homeworkNote[index].score.value,
                                    hint: 'Select the note',
                                    onChanged: (dynamic e) {
                                      homework.homeworkNote[index].setScore(e!);
                                      setState(() {});
                                    },
                                    items: notes
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e['type'],
                                            child: Text(
                                              e['name']!,
                                              style: context
                                                  .textTheme.bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                    ThemeModeController
                                                                .themeMode ==
                                                            ThemeMode.dark
                                                        ? const Shadow(
                                                            blurRadius: 10,
                                                            offset:
                                                                Offset(0, 1),
                                                          )
                                                        : const Shadow(),
                                                  ]),
                                            ),
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
                        Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<HomeworkBloc, HomeworkStates>(
                                bloc: widget.homeworkBloc,
                                builder: (context, state) {
                                  return MyElevatedButtonWidget(
                                    label: state is LoadingHomework
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text('Save'),
                                    icon: Icons.save_rounded,
                                    onPressed: () {
                                      if (!gkForm.currentState!.validate()) {
                                        return;
                                      }

                                      widget.homeworkBloc.add(
                                        SaveHomeworkEvent(homework: homework),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
