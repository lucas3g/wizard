// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class MyElevatedButtonWidget extends StatefulWidget {
  final Widget label;
  final IconData icon;
  final Function() onPressed;
  final double? height;
  const MyElevatedButtonWidget({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.height = 40,
  }) : super(key: key);

  @override
  State<MyElevatedButtonWidget> createState() => _MyElevatedButtonWidgetState();
}

class _MyElevatedButtonWidgetState extends State<MyElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: context.screenWidth * .40,
      child: ElevatedButton.icon(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppTheme.colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
        ),
        icon: Icon(widget.icon),
        label: widget.label,
      ),
    );
  }
}
