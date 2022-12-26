import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/components/my_elevated_button_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/entity/student.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/student_adapter.dart';
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

  late Student student;

  @override
  void initState() {
    super.initState();

    student = StudentAdapter.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Student'),
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            MyInputWidget(
              focusNode: fName,
              hintText: "Enter the student's name",
              label: 'Name',
              validator: (v) => student.studentName.validator(),
              value: student.studentName.toString(),
              onChanged: student.setStudentName,
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fClass,
              hintText: "Enter the student's class",
              label: 'Class',
              validator: (v) => student.studentClass.validator(),
              value: student.studentClass.toString(),
              onChanged: student.setStudentClass,
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fPhoneNumber,
              hintText: "Enter phone number",
              label: 'Phone Number',
              validator: (v) => student.studentPhoneNumber.validator(),
              value: student.studentPhoneNumber.toString(),
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
              validator: (v) => student.studentFather.validator(),
              value: student.studentFather.toString(),
              onChanged: student.setStudentFather,
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: MyElevatedButtonWidget(
                    label: 'Save',
                    icon: Icons.save_rounded,
                    onPressed: () {
                      Modular.to.pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
