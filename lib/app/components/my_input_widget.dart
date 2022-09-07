import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wizard/app/theme/app_theme.dart';

class MyInputWidget extends StatefulWidget {
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String hintText;
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final List<TextInputFormatter>? inputFormaters;
  final Function(String?)? onFieldSubmitted;
  final Function(String?)? onChanged;
  final TextEditingController textEditingController;
  final String? campoVazio;
  final AutovalidateMode? autovalidateMode;
  final TextCapitalization textCapitalization;
  final Function()? onTap;
  final void Function()? onEditingComplete;
  final bool readOnly;
  final bool expands;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;

  const MyInputWidget({
    Key? key,
    required this.focusNode,
    this.keyboardType = TextInputType.text,
    required this.hintText,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines,
    this.maxLength,
    this.minLines,
    this.inputFormaters,
    this.onFieldSubmitted,
    this.onChanged,
    required this.textEditingController,
    this.campoVazio,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onEditingComplete,
    this.readOnly = false,
    this.expands = false,
    this.textInputAction,
    this.textAlignVertical = TextAlignVertical.center,
  }) : super(key: key);

  @override
  State<MyInputWidget> createState() => _MyInputWidgetState();
}

class _MyInputWidgetState extends State<MyInputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: widget.autovalidateMode,
      textAlignVertical: widget.textAlignVertical!,
      expands: widget.expands,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      readOnly: widget.readOnly,
      onEditingComplete: widget.onEditingComplete,
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.campoVazio ?? '${widget.label} is empty';
        }
        if (widget.label == 'CPF' && !CPFValidator.isValid(value)) {
          return 'Invalid CPF';
        }
        if (widget.label == 'E-mail' &&
            !RegExp(
              r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
            ).hasMatch(value)) {
          return 'Invalid E-mail';
        }
        return null;
      },
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
          setState(() {});
        }
      },
      onTap: widget.onTap,
      obscureText: widget.obscureText,
      inputFormatters: widget.inputFormaters,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLength: widget.maxLength,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        counterText: '',
        hintText: widget.hintText,
        label: Text(widget.label),
        suffixIcon: widget.suffixIcon,
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
