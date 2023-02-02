// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:wizard/app/theme/app_theme.dart';

class MyDropDownButtonWidget<T> extends StatefulWidget {
  final FocusNode? focusNode;
  final String? Function(T)? validator;
  final List<DropdownMenuItem<T>>? items;
  final void Function(dynamic)? onChanged;
  final String hint;
  final dynamic value;
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
  dynamic retornaValor(dynamic value) {
    if (value.runtimeType is int) {
      return value < 0 ? null : value;
    }

    if (value.runtimeType is String) {
      return value.isEmpty ? null : value;
    }

    return null;
  }

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
      child: DropdownButtonFormField<dynamic>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        focusNode: widget.focusNode,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        iconEnabledColor: AppTheme.colors.primary,
        borderRadius: BorderRadius.circular(10),
        isDense: true,
        validator: widget.validator,
        value: retornaValor(widget.value),
        hint: Text(widget.hint),
        items: widget.items,
        onChanged: widget.onChanged,
      ),
    );
  }
}
