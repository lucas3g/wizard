// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:wizard/app/theme/app_theme.dart';

import '../../../../components/my_elevated_button_widget.dart';

class MyButtons {
  final String label;
  final IconData icon;
  final String route;
  final Map<String, dynamic>? args;

  MyButtons({
    required this.label,
    required this.icon,
    required this.route,
    this.args,
  });
}

class CardMenuWidget extends StatelessWidget {
  final String title;
  final List<MyButtons> myButtons;

  const CardMenuWidget({
    Key? key,
    required this.title,
    required this.myButtons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.colors.primary,
          ),
          child: Wrap(
            children: myButtons
                .map(
                  (button) => MyElevatedButtonWidget(
                    label: Text(button.label),
                    icon: button.icon,
                    onPressed: () {
                      Modular.to.pushNamed(
                        button.route,
                        arguments: button.args,
                      );
                    },
                  ),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
