import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';

class AddresWidget extends StatefulWidget {
  final User user;
  const AddresWidget({
    Key? key,
    required this.user,
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

  final gkForm = GlobalKey<FormState>();

  late User user;

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
        child: const MyAppBarWidget(titleAppbar: 'Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MyInputWidget(
                      focusNode: fZipCode,
                      hintText: 'Type your Zip code',
                      label: 'Zip code',
                      keyboardType: TextInputType.number,
                      inputFormaters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter()
                      ],
                      onChanged: user.address.setZipCode,
                      value: user.address.zipCode.value,
                      validator: (e) =>
                          user.address.zipCode.validate().exceptionOrNull(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
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
                inputFormaters: [UpperCaseTextFormatter()],
                onChanged: user.address.setState,
                value: user.address.state.value,
                validator: (e) =>
                    user.address.state.validate().exceptionOrNull(),
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fCity,
                hintText: 'Type your city',
                label: 'City',
                inputFormaters: [UpperCaseTextFormatter()],
                onChanged: user.address.setCity,
                value: user.address.city.value,
                validator: (e) =>
                    user.address.city.validate().exceptionOrNull(),
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fAddress,
                hintText: 'Type your address',
                label: 'Address',
                inputFormaters: [UpperCaseTextFormatter()],
                onChanged: user.address.setStreet,
                value: user.address.street.value,
                validator: (e) =>
                    user.address.street.validate().exceptionOrNull(),
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fNumber,
                hintText: 'Type your number',
                label: 'Number',
                inputFormaters: [UpperCaseTextFormatter()],
                onChanged: user.address.setNumber,
                value: user.address.number.value,
                validator: (e) =>
                    user.address.number.validate().exceptionOrNull(),
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fDistrict,
                hintText: 'Type your district',
                label: 'District',
                inputFormaters: [UpperCaseTextFormatter()],
                onChanged: user.address.setDistrict,
                value: user.address.district.value,
                validator: (e) =>
                    user.address.district.validate().exceptionOrNull(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
