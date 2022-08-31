import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/utils/formatters.dart';

class AddresWidget extends StatefulWidget {
  final Size sizeAppBar;
  const AddresWidget({
    Key? key,
    required this.sizeAppBar,
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

  final gkZipCode = GlobalKey<FormState>();
  final gkState = GlobalKey<FormState>();
  final gkCity = GlobalKey<FormState>();
  final gkAddress = GlobalKey<FormState>();
  final gkNumber = GlobalKey<FormState>();
  final gkDistrict = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: widget.sizeAppBar,
        child: const MyAppBarWidget(titleAppbar: 'Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyInputWidget(
              focusNode: fZipCode,
              hintText: 'Type your Zip code',
              label: 'Zip code',
              campoVazio: 'Zip code cannot be empty ',
              textEditingController: zipCodeController,
              formKey: gkZipCode,
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fState,
              hintText: 'Type your state',
              label: 'State',
              campoVazio: 'State cannot be empty',
              textEditingController: stateController,
              formKey: gkState,
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fCity,
              hintText: 'Type your city',
              label: 'City',
              campoVazio: 'City cannot be empty',
              textEditingController: cityController,
              formKey: gkCity,
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fAddress,
              hintText: 'Type your address',
              label: 'Address',
              campoVazio: 'Address cannot be empty',
              textEditingController: addressController,
              formKey: gkAddress,
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fNumber,
              hintText: 'Type your number',
              label: 'Number',
              campoVazio: 'Number cannot be empty',
              textEditingController: numberController,
              formKey: gkNumber,
              inputFormaters: [UpperCaseTextFormatter()],
            ),
            const SizedBox(height: 10),
            MyInputWidget(
              focusNode: fDistrict,
              hintText: 'Type your district',
              label: 'District',
              campoVazio: 'District cannot be empty',
              textEditingController: districtController,
              formKey: gkDistrict,
              inputFormaters: [UpperCaseTextFormatter()],
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
