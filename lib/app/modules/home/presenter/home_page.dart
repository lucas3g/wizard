import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_elevated_button_widget.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: context.sizeAppbar,
        child: const MyAppBarWidget(titleAppbar: 'Wizard School'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppTheme.colors.primary,
          ),
          child: GridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            children: [
              MyElevatedButtonWidget(
                label: 'New Student',
                icon: Icons.person_add_rounded,
                onPressed: () {
                  Modular.to.pushNamed('/home/student/');
                },
              ),
              MyElevatedButtonWidget(
                label: 'New Class',
                icon: Icons.class_rounded,
                onPressed: () {},
              ),
              MyElevatedButtonWidget(
                label: 'Mark Presence',
                icon: Icons.mark_chat_read_rounded,
                onPressed: () {},
              ),
              MyElevatedButtonWidget(
                label: 'Note by Theme',
                icon: Icons.note_alt_rounded,
                onPressed: () {},
              ),
              MyElevatedButtonWidget(
                label: 'Note by Review',
                icon: Icons.reviews_rounded,
                onPressed: () {},
              ),
              MyElevatedButtonWidget(
                label: 'General Report',
                icon: Icons.newspaper_rounded,
                onPressed: () {},
              ),
              MyElevatedButtonWidget(
                label: 'Student List',
                icon: Icons.list_rounded,
                onPressed: () {},
              ),
              MyElevatedButtonWidget(
                label: 'Class List',
                icon: Icons.list_rounded,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
