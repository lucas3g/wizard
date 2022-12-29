import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_elevated_button_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/student_adapter.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({super.key});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  FocusNode fName = FocusNode();
  FocusNode fClass = FocusNode();
  FocusNode fPhoneNumber = FocusNode();
  FocusNode fFather = FocusNode();

  final gkForm = GlobalKey<FormState>();

  late Student student;

  @override
  void initState() {
    super.initState();

    student = StudentAdapter.empty();
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
              MyInputWidget(
                focusNode: fClass,
                hintText: "Enter the student's class",
                label: 'Class',
                validator: (v) =>
                    student.studentClass.validate().exceptionOrNull(),
                value: student.studentClass.value,
                onChanged: student.setStudentClass,
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
                hintText: "Enter father's name",
                label: 'Father',
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
                    child: MyElevatedButtonWidget(
                      label: const Text('Save'),
                      icon: Icons.save_rounded,
                      onPressed: () {},
                    ),
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
