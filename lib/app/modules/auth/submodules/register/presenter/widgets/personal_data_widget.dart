import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';

class PersonalDataWidget extends StatefulWidget {
  final User user;
  const PersonalDataWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<PersonalDataWidget> createState() => _PersonalDataWidgetState();
}

class _PersonalDataWidgetState extends State<PersonalDataWidget> {
  late User user;

  final fName = FocusNode();
  final fLastName = FocusNode();
  final fCPF = FocusNode();
  final fBirthday = FocusNode();

  @override
  void initState() {
    super.initState();

    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: context.sizeAppbar,
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
                label: 'Name and Last Name',
                onChanged: user.setName,
                value: user.name.value,
                validator: (e) => user.name.validate().exceptionOrNull(),
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fCPF,
                hintText: 'Type your CPF',
                label: 'CPF',
                value: user.cpf.value,
                onChanged: user.setCPF,
                validator: (v) => user.cpf.validate().exceptionOrNull(),
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
                value: user.birthDay.value,
                onChanged: user.setBirthday,
                validator: (v) => user.birthDay.validate().exceptionOrNull(),
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
