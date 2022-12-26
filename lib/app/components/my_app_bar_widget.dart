import 'dart:io';

import 'package:flutter/material.dart';

import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class MyAppBarWidget extends StatefulWidget {
  final String titleAppbar;
  const MyAppBarWidget({
    Key? key,
    required this.titleAppbar,
  }) : super(key: key);

  @override
  State<MyAppBarWidget> createState() => _MyAppBarWidgetState();
}

class _MyAppBarWidgetState extends State<MyAppBarWidget> {
  final height = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: height + (Platform.isWindows ? 10 : 40),
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: AppTheme.colors.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.titleAppbar,
                style: AppTheme.textStyles.titleAppBar,
              ),
            ],
          ),
          Text(
            'Teacher: Tainá Salami',
            style: AppTheme.textStyles.subTitleAppBar,
          ),
        ],
      ),
    );
  }
}
