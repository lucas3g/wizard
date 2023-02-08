// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/events/student_events.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/states/student_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class StudentPage extends StatefulWidget {
  final StudentBloc studentBloc;

  const StudentPage({
    Key? key,
    required this.studentBloc,
  }) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  @override
  void initState() {
    super.initState();

    widget.studentBloc.add(
      GetStudentByTeacherEvent(
        teacherID: GlobalUser.instance.user.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'Student List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: BlocBuilder<StudentBloc, StudentStates>(
            bloc: widget.studentBloc,
            builder: (context, state) {
              if (state is! SuccessGetStudentByTeacher) {
                return const Center(child: CircularProgressIndicator());
              }

              final students = state.students;

              if (students.isEmpty) {
                return const Center(
                  child: Text('Student list is empty :('),
                );
              }

              return ListView.separated(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];

                  return Container(
                    padding: const EdgeInsets.only(left: 10),
                    height: 50,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: SwipeActionCell(
                      key: ObjectKey(student),
                      trailingActions: <SwipeAction>[
                        SwipeAction(
                          widthSpace: 90,
                          backgroundRadius: 10,
                          style: AppTheme.textStyles.labelRemoveSwipeAction,
                          title: "Remove",
                          onTap: (CompletionHandler handler) async {
                            students.removeAt(index);
                            setState(() {});
                          },
                          color: Colors.red,
                        ),
                        SwipeAction(
                          widthSpace: 90,
                          backgroundRadius: 10,
                          style: AppTheme.textStyles.labelRemoveSwipeAction,
                          title: "Edit",
                          onTap: (CompletionHandler handler) async {
                            await Modular.to.pushNamed(
                              '/home/student/edit',
                              arguments: {
                                'student': student,
                                'editing': true,
                              },
                            );

                            widget.studentBloc.add(
                              GetStudentByTeacherEvent(
                                teacherID: GlobalUser.instance.user.id,
                              ),
                            );
                          },
                          color: Colors.orange,
                        ),
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          student.studentName.value,
                          style: AppTheme.textStyles.titleSwipeAction,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            }),
      ),
    );
  }
}
