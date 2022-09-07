import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class AddresWidget extends StatefulWidget {
  const AddresWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddresWidget> createState() => _AddresWidgetState();
}

class _AddresWidgetState extends State<AddresWidget> {
  final fZipCode = FocusNode();
  final fState = FocusNode();
  final fCity = FocusNode();
  final fAddress = FocusNode();
  final fNumber = FocusNode();
  final fDistrict = FocusNode();

  final zipCodeController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final numberController = TextEditingController();
  final districtController = TextEditingController();

  final gkForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: context.sizeAppbar,
        child: const MyAppBarWidget(titleAppbar: 'Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyInputWidget(
                      focusNode: fZipCode,
                      hintText: 'Type your Zip code',
                      label: 'Zip code',
                      campoVazio: 'Zip code cannot be empty',
                      textEditingController: zipCodeController,
                      keyboardType: TextInputType.number,
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter()
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (zipCodeController.text.isEmpty) {
                          MySnackBar(message: 'Zip code cannot be empty');
                        }
                      },
                      child: const Text('Buscar Cidade'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fState,
                hintText: 'Type your state',
                label: 'State',
                campoVazio: 'State cannot be empty',
                textEditingController: stateController,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fCity,
                hintText: 'Type your city',
                label: 'City',
                campoVazio: 'City cannot be empty',
                textEditingController: cityController,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fAddress,
                hintText: 'Type your address',
                label: 'Address',
                campoVazio: 'Address cannot be empty',
                textEditingController: addressController,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fNumber,
                hintText: 'Type your number',
                label: 'Number',
                campoVazio: 'Number cannot be empty',
                textEditingController: numberController,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fDistrict,
                hintText: 'Type your district',
                label: 'District',
                campoVazio: 'District cannot be empty',
                textEditingController: districtController,
                inputFormaters: [UpperCaseTextFormatter()],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
