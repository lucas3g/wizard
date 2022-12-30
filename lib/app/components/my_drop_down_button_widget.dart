// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:wizard/app/theme/app_theme.dart';

class MyDropDownButtonWidget extends StatefulWidget {
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String hint;

  const MyDropDownButtonWidget({
    Key? key,
    required this.focusNode,
    this.validator,
    this.items,
    this.onChanged,
    required this.hint,
  }) : super(key: key);

  @override
  State<MyDropDownButtonWidget> createState() => _MyDropDownButtonWidgetState();
}

class _MyDropDownButtonWidgetState extends State<MyDropDownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppTheme.colors.primary,
        ),
      ),
      child: DropdownButtonFormField<String>(
        focusNode: widget.focusNode,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        iconEnabledColor: AppTheme.colors.primary,
        borderRadius: BorderRadius.circular(10),
        isDense: true,
        validator: widget.validator,
        value: null,
        hint: Text(widget.hint),
        items: widget.items,
        onChanged: widget.onChanged,
      ),
    );
  }
}
