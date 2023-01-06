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
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/adapters/student_adapter.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/events/student_events.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/states/student_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class EditStudentWidget extends StatefulWidget {
  final ClassBloc classBloc;
  final StudentBloc studentBloc;

  const EditStudentWidget({
    Key? key,
    required this.classBloc,
    required this.studentBloc,
  }) : super(key: key);

  @override
  State<EditStudentWidget> createState() => _EditStudentWidgetState();
}

class _EditStudentWidgetState extends State<EditStudentWidget> {
  FocusNode fName = FocusNode();
  FocusNode fClass = FocusNode();
  FocusNode fPhoneNumber = FocusNode();
  FocusNode fFather = FocusNode();

  final gkForm = GlobalKey<FormState>();

  late Student student;

  late StreamSubscription sub;

  final args = Modular.args;

  @override
  void initState() {
    super.initState();

    if (args.data == null) {
      student = StudentAdapter.empty();
    } else {
      student = args.data as Student;
    }

    widget.classBloc.add(
      GetClassesByIdTeacher(
        idTeacher: ClassIDTeacher(
          GlobalUser.instance.user!.id.value,
        ),
      ),
    );

    sub = widget.studentBloc.stream.listen((state) async {
      if (state is SuccessSaveStudent) {
        MySnackBar(
          message: 'Student save with success',
          type: TypeSnackBar.success,
        );
        await Future.delayed(const Duration(milliseconds: 300));
        Modular.to.pop();
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
        child: const MyAppBarWidget(titleAppbar: 'New Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Form(
          key: gkForm,
          child: Column(
            children: [
              MyInputWidget(
                focusNode: fName,
                hintText: "Enter the student's name",
                label: 'Name',
                validator: (v) =>
                    student.studentName.validate().exceptionOrNull(),
                value: student.studentName.value,
                onChanged: student.setStudentName,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 10),
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
                        student.studentClass.validate().exceptionOrNull(),
                    onChanged: (String? e) => student.setStudentClass(e!),
                    value: student.studentClass.value,
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
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fPhoneNumber,
                hintText: "Enter phone number",
                label: 'Phone Number',
                validator: (v) =>
                    student.studentPhoneNumber.validate().exceptionOrNull(),
                value: student.studentPhoneNumber.value,
                onChanged: student.setStudentPhoneNumber,
                keyboardType: TextInputType.number,
                inputFormaters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fFather,
                hintText: "Enter the name of the father or mother",
                label: 'Parents',
                validator: (v) =>
                    student.studentParents.validate().exceptionOrNull(),
                value: student.studentParents.value,
                onChanged: student.setStudentFather,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: BlocBuilder<StudentBloc, StudentStates>(
                        bloc: widget.studentBloc,
                        builder: (context, state) {
                          return MyElevatedButtonWidget(
                            label: state is LoadingStudent
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text('Save'),
                            icon: Icons.save_rounded,
                            onPressed: () {
                              widget.studentBloc.add(
                                SaveStudentEvent(student: student),
                              );
                            },
                          );
                        }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
