// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_elevated_button_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/adapters/class_adapter.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
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

  final fName = FocusNode();
  final fTeacher = FocusNode();

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
            MyInputWidget(
              focusNode: fTeacher,
              hintText: "Enter the teacher's name",
              label: 'Teacher',
              onChanged: pClass.setIdTeacher,
              validator: (v) => pClass.idTeacher.validate().exceptionOrNull(),
              value: pClass.idTeacher.value,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: MyElevatedButtonWidget(
                    label: 'Save',
                    icon: Icons.save,
                    onPressed: () {
                      widget.classBloc.add(SaveClassEvent(pClass: pClass));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
