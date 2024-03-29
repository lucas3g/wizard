// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:wizard/app/utils/constants.dart';

import '../../../../shared/components/my_elevated_button_widget.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  margin: const EdgeInsets.only(right: kPadding / 4),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: context.myTheme.secondaryContainer,
                        width: 5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: kPadding / 4),
              child: Text(
                title,
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Container(
          width: myButtons.length > 1 ? context.screenWidth : null,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.myTheme.secondaryContainer,
          ),
          child: Wrap(
            alignment: myButtons.length > 1
                ? WrapAlignment.center
                : WrapAlignment.start,
            spacing: 20,
            runSpacing: 10,
            children: myButtons
                .map(
                  (button) => MyElevatedButtonWidget(
                    height: 80,
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
