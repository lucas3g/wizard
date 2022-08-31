import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

  final gkName = GlobalKey<FormState>();
  final gkLastName = GlobalKey<FormState>();
  final gkCPF = GlobalKey<FormState>();
  final gkBirthDay = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: widget.sizeAppBar,
        child: const MyAppBarWidget(titleAppbar: 'Personal data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyInputWidget(
              focusNode: fName,
              hintText: 'Type your name',
              label: 'Name',
              campoVazio: 'Name cannot be empty ',
              textEditingController: nameController,
              formKey: gkName,
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fLastName,
              hintText: 'Type your last name',
              label: 'Last Name',
              campoVazio: 'Last name cannot be empty',
              textEditingController: lastNameController,
              formKey: gkLastName,
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fCPF,
              hintText: 'Type your CPF',
              label: 'CPF',
              campoVazio: 'CPF cannot be empty',
              textEditingController: cpfController,
              formKey: gkCPF,
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
              formKey: gkBirthDay,
              keyboardType: TextInputType.number,
              inputFormaters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, double.infinity),
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () {
                  Modular.to.navigate('/auth/');
                },
                child: const Text('Cancel'),
              ),
            ),
            Container(
              height: 50,
              width: 2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, double.infinity),
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () {},
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
