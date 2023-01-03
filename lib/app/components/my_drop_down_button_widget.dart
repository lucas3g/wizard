// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:wizard/app/theme/app_theme.dart';

class MyDropDownButtonWidget extends StatefulWidget {
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  final String hint;
  final String value;
  final bool? border;

  const MyDropDownButtonWidget({
    Key? key,
    this.focusNode,
    this.validator,
    this.items,
    this.onChanged,
    required this.value,
    required this.hint,
    this.border = true,
  }) : super(key: key);

  @override
  State<MyDropDownButtonWidget> createState() => _MyDropDownButtonWidgetState();
}

class _MyDropDownButtonWidgetState extends State<MyDropDownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: widget.border!
            ? Border.all(
                color: AppTheme.colors.primary,
              )
            : null,
      ),
      child: DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: widget.focusNode,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        iconEnabledColor: AppTheme.colors.primary,
        borderRadius: BorderRadius.circular(10),
        isDense: true,
        validator: widget.validator,
        value: widget.value.isEmpty ? null : widget.value,
        hint: Text(widget.hint),
        items: widget.items,
        onChanged: widget.onChanged,
      ),
    );
  }
}
