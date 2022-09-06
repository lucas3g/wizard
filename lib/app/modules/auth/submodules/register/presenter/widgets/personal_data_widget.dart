import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/utils/formatters.dart';

class PersonalDataWidget extends StatefulWidget {
  final Size sizeAppBar;
  const PersonalDataWidget({
    Key? key,
    required this.sizeAppBar,
  }) : super(key: key);

  @override
  State<PersonalDataWidget> createState() => _PersonalDataWidgetState();
}

class _PersonalDataWidgetState extends State<PersonalDataWidget> {
  final fName = FocusNode();
  final fLastName = FocusNode();
  final fCPF = FocusNode();
  final fBirthday = FocusNode();

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cpfController = TextEditingController();
  final birthDayController = TextEditingController();

  final gkForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: widget.sizeAppBar,
        child: const MyAppBarWidget(titleAppbar: 'Personal data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              MyInputWidget(
                focusNode: fName,
                hintText: 'Type your name',
                label: 'Name',
                campoVazio: 'Name cannot be empty ',
                textEditingController: nameController,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fLastName,
                hintText: 'Type your last name',
                label: 'Last Name',
                campoVazio: 'Last name cannot be empty',
                textEditingController: lastNameController,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fCPF,
                hintText: 'Type your CPF',
                label: 'CPF',
                campoVazio: 'CPF cannot be empty',
                textEditingController: cpfController,
                keyboardType: TextInputType.number,
                inputFormaters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fBirthday,
                hintText: 'Type your birthday',
                label: 'Birthday',
                campoVazio: 'Birthday cannot be empty',
                textEditingController: birthDayController,
                keyboardType: TextInputType.number,
                inputFormaters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter()
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
