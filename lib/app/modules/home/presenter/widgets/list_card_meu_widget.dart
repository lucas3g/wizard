import 'package:flutter/material.dart';
import 'package:wizard/app/modules/home/presenter/widgets/card_menu_widget.dart';

class ListCardMenuWidget extends StatelessWidget {
  const ListCardMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CardMenuWidget(
          title: 'Student',
          myButtons: [
            MyButtons(
              label: 'New Student',
              icon: Icons.person_add_rounded,
              route: '/home/student/edit',
              args: {'editing': false},
            ),
            MyButtons(
              label: 'Student List',
              icon: Icons.list_rounded,
              route: '/home/student/',
            ),
          ],
        ),
        const SizedBox(height: 10),
        CardMenuWidget(
          title: 'Class',
          myButtons: [
            MyButtons(
              label: 'New Class',
              icon: Icons.class_rounded,
              route: '/home/class/edit',
              args: {'editing': false},
            ),
            MyButtons(
              label: 'Class List',
              icon: Icons.list_rounded,
              route: '/home/class/',
            ),
          ],
        ),
        const SizedBox(height: 10),
        CardMenuWidget(
          title: 'Presence',
          myButtons: [
            MyButtons(
              label: 'Mark Presence',
              icon: Icons.mark_chat_read_rounded,
              route: '/home/presence/',
            ),
            MyButtons(
              label: 'Presences List',
              icon: Icons.list_rounded,
              route: '/home/presence/list',
            ),
          ],
        ),
        const SizedBox(height: 10),
        CardMenuWidget(
          title: 'Homework',
          myButtons: [
            MyButtons(
              label: 'Note by Homework',
              icon: Icons.note_alt_rounded,
              route: '/home/homework/',
            ),
            MyButtons(
              label: 'Homework List',
              icon: Icons.list_rounded,
              route: '/home/homework/list',
            ),
          ],
        ),
        const SizedBox(height: 10),
        CardMenuWidget(
          title: 'Review',
          myButtons: [
            MyButtons(
              label: 'Note by Review',
              icon: Icons.note_alt_rounded,
              route: '/home/review/',
            ),
            MyButtons(
              label: 'Review List',
              icon: Icons.list_rounded,
              route: '/home/review/list',
            ),
          ],
        ),
        const SizedBox(height: 10),
        CardMenuWidget(
          title: 'Action',
          myButtons: [
            MyButtons(
              label: 'General Report',
              icon: Icons.newspaper_rounded,
              route: '/home/report/',
            ),
          ],
        ),
      ],
    );
  }
}
