import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wizard/app/theme/app_theme.dart';

class MyInputWidget extends StatelessWidget {
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final String? hintText;
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final List<TextInputFormatter>? inputFormaters;
  final Function(String?)? onFieldSubmitted;
  final Function(String)? onChanged;
  final TextCapitalization textCapitalization;
  final Function()? onTap;
  final void Function()? onEditingComplete;
  final bool readOnly;
  final bool expands;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final String? Function(String?)? validator;
  final String value;

  const MyInputWidget({
    Key? key,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.hintText,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines,
    this.maxLength,
    this.minLines,
    this.inputFormaters,
    this.onFieldSubmitted,
    this.onChanged,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onEditingComplete,
    this.readOnly = false,
    this.expands = false,
    this.textInputAction,
    this.textAlignVertical = TextAlignVertical.center,
    required this.validator,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: value,
      textAlignVertical: textAlignVertical!,
      expands: expands,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly,
      onEditingComplete: onEditingComplete,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      validator: validator,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      inputFormatters: inputFormaters,
      onFieldSubmitted: onFieldSubmitted,
      maxLength: maxLength,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        counterText: '',
        hintText: hintText,
        label: Text(label),
        suffixIcon: suffixIcon,
        filled: true,
        isDense: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey.shade700,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppTheme.colors.primary,
          ),
        ),
      ),
    );
  }
}
