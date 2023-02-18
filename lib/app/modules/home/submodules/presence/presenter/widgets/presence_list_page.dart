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
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_check.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/events/presence_events.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/presence_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/states/presence_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/shared/components/my_app_bar_widget.dart';
import 'package:wizard/app/shared/components/my_drop_down_button_widget.dart';
import 'package:wizard/app/shared/components/my_elevated_button_widget.dart';
import 'package:wizard/app/shared/components/my_input_widget.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class PresenceListPage extends StatefulWidget {
  final ClassBloc classBloc;
  final StudentBloc studentBloc;
  final PresenceBloc presenceBloc;

  const PresenceListPage({
    Key? key,
    required this.classBloc,
    required this.studentBloc,
    required this.presenceBloc,
  }) : super(key: key);

  @override
  State<PresenceListPage> createState() => _PresenceListPageState();
}

class _PresenceListPageState extends State<PresenceListPage> {
  final dateController = TextEditingController();

  final fClass = FocusNode();
  final fDate = FocusNode();

  late bool visibleList = false;

  late int selectedValue = -1;

  final gkForm = GlobalKey<FormState>();

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    _fetchClasses();

    sub = widget.presenceBloc.stream.listen((state) {
      if (state is SuccessUpdatePresence) {
        MySnackBar(
          message: 'Presence list updated successfully',
          type: TypeSnackBar.success,
        );

        Modular.to.pop();
      }

      if (state is ErrorPresence) {
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

  void setPresence(PresenceCheck check) {
    if (check.presencePresent.value == 'Present') {
      check.setPresencePresent('Absent');
    } else {
      check.setPresencePresent('Present');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'Presence List'),
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
                    hintText: 'Enter the date of presence',
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

                            widget.presenceBloc.add(
                              GetPresenceByClassAndDateEvent(
                                pClass: selectedValue,
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
              child: BlocBuilder<PresenceBloc, PresenceStates>(
                buildWhen: (previous, current) {
                  return current is SuccessUpdatePresence ||
                      current is SuccessSavePresence ||
                      current is SuccessGetPresenceByClass;
                },
                bloc: widget.presenceBloc,
                builder: (context, state) {
                  if (state is ErrorPresence) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  if (state is! SuccessGetPresenceByClass) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final presence = state.presences[0];
                  final checks = presence.presenceCheck;

                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              final check = checks[index];

                              return Container(
                                decoration: BoxDecoration(
                                    color:
                                        check.presencePresent.value == 'Absent'
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
                                  title: Text(check.student.studentName.value),
                                  onTap: () {
                                    setPresence(check);
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            itemCount: checks.length,
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
                                        UpdatePresenceEvent(presence: presence),
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
