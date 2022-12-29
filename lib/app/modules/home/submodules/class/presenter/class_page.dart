// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_elevated_button_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/adapters/class_adapter.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class ClassPage extends StatefulWidget {
  final ClassBloc classBloc;

  const ClassPage({
    Key? key,
    required this.classBloc,
  }) : super(key: key);

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
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

  @override
  void initState() {
    super.initState();

    pClass = ClassAdapter.empty();
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppTheme.colors.primary,
                ),
              ),
              child: DropdownButtonFormField<String>(
                focusNode: fDayWeek,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                iconEnabledColor: AppTheme.colors.primary,
                borderRadius: BorderRadius.circular(10),
                isDense: true,
                validator: (v) => pClass.dayWeek.validate().exceptionOrNull(),
                value: null,
                hint: const Text('Select the day of the week'),
                items: daysWeek
                    .map(
                      (String e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (String? value) => pClass.setDayWeek(value!),
              ),
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fSchedule,
              hintText: 'Enter the schedule',
              label: 'Schedule',
              onChanged: pClass.setSchedule,
              validator: (v) => pClass.schedule.validate().exceptionOrNull(),
              value: pClass.schedule.value,
              inputFormaters: [TextInputMask(mask: '99:99 às 99:99')],
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
                            widget.classBloc.add(
                              SaveClassEvent(pClass: pClass),
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
