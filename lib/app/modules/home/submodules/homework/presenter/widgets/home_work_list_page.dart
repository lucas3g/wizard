// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';

import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/events/homework_events.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/homework_bloc.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/states/homework_states.dart';
import 'package:wizard/app/shared/components/my_app_bar_widget.dart';
import 'package:wizard/app/shared/components/my_drop_down_button_widget.dart';
import 'package:wizard/app/shared/components/my_elevated_button_widget.dart';
import 'package:wizard/app/shared/components/my_input_widget.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class HomeworkListPage extends StatefulWidget {
  final ClassBloc classBloc;
  final HomeworkBloc homeworkBloc;

  const HomeworkListPage({
    Key? key,
    required this.classBloc,
    required this.homeworkBloc,
  }) : super(key: key);

  @override
  State<HomeworkListPage> createState() => _HomeworkListPageState();
}

class _HomeworkListPageState extends State<HomeworkListPage> {
  final dateController = TextEditingController();

  final fClass = FocusNode();
  final fDate = FocusNode();
  final fNumber = FocusNode();

  late bool visibleList = false;

  late int selectedValue = -1;

  final gkForm = GlobalKey<FormState>();

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    _fetchClasses();

    sub = widget.homeworkBloc.stream.listen((state) {
      if (state is SuccessUpdateHomework) {
        MySnackBar(
          message: 'Homework updated successfully',
          type: TypeSnackBar.success,
        );

        Modular.to.pop();
      }

      if (state is ErrorHomework) {
        MySnackBar(
          message: state.message,
          type: TypeSnackBar.error,
        );
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();

    super.dispose();
  }

  void _fetchClasses() {
    widget.classBloc.add(
      GetClassesByIdTeacher(
        idTeacher: ClassIDTeacher(
          GlobalUser.instance.user.id.value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'Homework List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            Form(
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
                        validator: (v) {
                          if (v == null) {
                            return 'Select a class';
                          }

                          return null;
                        },
                        onChanged: (dynamic e) {
                          setState(() {
                            selectedValue = e;
                          });
                        },
                        value: selectedValue,
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
                  const SizedBox(height: 15),
                  MyInputWidget(
                    controller: dateController,
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
                        dateController.text = selectedDate.DiaMesAnoTextField();
                      }
                    },
                    focusNode: fDate,
                    hintText: 'Enter the date of homework',
                    label: 'Date',
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Date cannot be blank';
                      }

                      return null;
                    },
                    readOnly: true,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: MyElevatedButtonWidget(
                          label: const Text('Search'),
                          icon: Icons.search,
                          onPressed: () {
                            if (!gkForm.currentState!.validate()) {
                              return;
                            }

                            setState(() {
                              visibleList = true;
                            });

                            widget.homeworkBloc.add(
                              GetHomeworksByClassAndDateEvent(
                                classID: selectedValue,
                                date: dateController.text,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Visibility(
              visible: visibleList,
              child: BlocBuilder<HomeworkBloc, HomeworkStates>(
                bloc: widget.homeworkBloc,
                builder: (context, state) {
                  if (state is LoadingHomework) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is ErrorHomework) {
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  }

                  if (state is SuccessGetHomeworksByClassAndDate) {
                    final homework = state.homeworks[0];
                    final homeworkNotes = homework.homeworkNote;

                    return Expanded(
                      child: Column(
                        children: [
                          MyInputWidget(
                            focusNode: fNumber,
                            hintText: 'Enter the number',
                            label: 'Number',
                            value: homework.homeworkName.value,
                            onChanged: homework.setHomeworkName,
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final note = homeworkNotes[index];

                                return Container(
                                  decoration: BoxDecoration(
                                    color: makeBackGroundColorListTile(
                                      note.score.value,
                                      context,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: note.score.value.isNotEmpty
                                          ? makeBackGroundColorListTile(
                                              homework.homeworkNote[index].score
                                                  .value,
                                              context,
                                            )
                                          : context.myTheme.onPrimary,
                                    ),
                                  ),
                                  child: ListTile(
                                    title: Text(note.student.studentName.value),
                                    trailing: SizedBox(
                                      width: 160,
                                      child: MyDropDownButtonWidget(
                                        border: false,
                                        validator: (v) => homework
                                            .homeworkNote[index].score
                                            .validate()
                                            .exceptionOrNull(),
                                        value: note.score.value,
                                        hint: 'Select the note',
                                        onChanged: (dynamic e) {
                                          note.setScore(e!);
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
                              itemCount: homeworkNotes.length,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child:
                                    BlocBuilder<HomeworkBloc, HomeworkStates>(
                                  bloc: widget.homeworkBloc,
                                  builder: (context, state) {
                                    return MyElevatedButtonWidget(
                                      label: state is LoadingHomework
                                          ? const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : const Text('Save'),
                                      icon: Icons.save_rounded,
                                      onPressed: () {
                                        widget.homeworkBloc.add(
                                          UpdateHomeworkEvent(
                                              homework: homework),
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
                  }

                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
