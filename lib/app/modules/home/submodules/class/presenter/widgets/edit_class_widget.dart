// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_drop_down_button_widget.dart';
import 'package:wizard/app/components/my_elevated_button_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/adapters/class_adapter.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class EditClassWidget extends StatefulWidget {
  final ClassBloc classBloc;

  const EditClassWidget({
    Key? key,
    required this.classBloc,
  }) : super(key: key);

  @override
  State<EditClassWidget> createState() => _EditClassWidgetState();
}

class _EditClassWidgetState extends State<EditClassWidget> {
  late Class pClass;

  final daysWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final fName = FocusNode();
  final fTeacher = FocusNode();
  final fDayWeek = FocusNode();
  final fSchedule = FocusNode();

  late StreamSubscription sub;

  final args = Modular.args;

  @override
  void initState() {
    super.initState();

    if (!(args.data['editing'] as bool)) {
      pClass = ClassAdapter.empty();
    } else {
      pClass = args.data['class'] as Class;
    }

    sub = widget.classBloc.stream.listen((state) async {
      if (state is SuccessCreateClass) {
        MySnackBar(
          message: 'Class created successfully',
          type: TypeSnackBar.success,
        );
        await Future.delayed(const Duration(milliseconds: 300));
        Modular.to.pop();
      }

      if (state is SuccessUpdateClass) {
        MySnackBar(
          message: 'Class updated successfully',
          type: TypeSnackBar.success,
        );
        await Future.delayed(const Duration(milliseconds: 300));
        Modular.to.pop();
      }

      if (state is ErrorClass) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'New Class'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyInputWidget(
              focusNode: fName,
              hintText: 'Enter the class name',
              label: 'Name',
              onChanged: pClass.setClassName,
              validator: (v) => pClass.name.validate().exceptionOrNull(),
              value: pClass.name.value,
            ),
            const SizedBox(height: 10),
            MyDropDownButtonWidget(
              focusNode: fDayWeek,
              validator: (v) => pClass.dayWeek.validate().exceptionOrNull(),
              value: pClass.dayWeek.value,
              hint: 'Select the day of the week',
              items: daysWeek
                  .map(
                    (String e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (dynamic value) => pClass.setDayWeek(value!),
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fSchedule,
              label: 'Schedule',
              hintText: '00:00 às 00:00',
              onChanged: pClass.setSchedule,
              validator: (v) => pClass.schedule.validate().exceptionOrNull(),
              value: pClass.schedule.value,
              inputFormaters: [
                TextInputMask(
                  mask: '99:99 às 99:99',
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: BlocBuilder<ClassBloc, ClassStates>(
                      bloc: widget.classBloc,
                      builder: (context, state) {
                        return MyElevatedButtonWidget(
                          label: state is LoadingClass
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text('Save'),
                          icon: Icons.save,
                          onPressed: () {
                            if (args.data['editing'] as bool) {
                              widget.classBloc.add(
                                UpdateClassEvent(pClass: pClass),
                              );

                              return;
                            }

                            widget.classBloc.add(
                              CreateClassEvent(pClass: pClass),
                            );
                          },
                        );
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
