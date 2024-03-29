// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/core_module/services/themeMode/theme_mode_controller.dart';

import 'package:wizard/app/shared/components/my_app_bar_widget.dart';
import 'package:wizard/app/shared/components/my_drop_down_button_widget.dart';
import 'package:wizard/app/shared/components/my_elevated_button_widget.dart';
import 'package:wizard/app/shared/components/my_input_widget.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/events/review_events.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/review_bloc.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/states/review_states.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/vos/review_note.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/adapters/review_adapter.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/events/student_events.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/states/student_states.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/formatters.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class ReviewPage extends StatefulWidget {
  final ClassBloc classBloc;
  final StudentBloc studentBloc;
  final ReviewBloc reviewBloc;

  const ReviewPage({
    Key? key,
    required this.classBloc,
    required this.studentBloc,
    required this.reviewBloc,
  }) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final dataController = TextEditingController();

  final fClass = FocusNode();
  final fName = FocusNode();
  final fDate = FocusNode();

  late bool visibleList = false;

  late Review review;

  late StreamSubscription sub;
  late StreamSubscription subReview;

  final gkForm = GlobalKey<FormState>();
  final gkFormNotes = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    widget.classBloc.add(
      GetClassesByIdTeacher(
        idTeacher: ClassIDTeacher(
          GlobalUser.instance.user.id.value,
        ),
      ),
    );

    sub = widget.studentBloc.stream.listen((state) {
      if (state is SuccessGetStudentByClass) {
        review.reviewNote.clear();

        for (var student in state.students) {
          review.reviewNote.add(
            ReviewNote(
              id: const IdVO(-1),
              student: student,
              score: '',
            ),
          );
        }
      }
    });

    subReview = widget.reviewBloc.stream.listen((state) async {
      if (state is SuccessSaveReview) {
        MySnackBar(
          message: 'Review save with success',
          type: TypeSnackBar.success,
        );
        await Future.delayed(const Duration(milliseconds: 300));
        Modular.to.pop();
      }

      if (state is ErrorReview) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }
    });

    review = ReviewAdapter.empty();
  }

  @override
  void dispose() {
    sub.cancel();
    subReview.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'Note by Review'),
      ),
      body: Form(
        key: gkForm,
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: ListView(
            shrinkWrap: true,
            children: [
              BlocBuilder<ClassBloc, ClassStates>(
                bloc: widget.classBloc,
                builder: (context, state) {
                  if (state is! SuccessGetListClass) {
                    return Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }

                  final classes = state.classes;

                  return MyDropDownButtonWidget(
                    focusNode: fClass,
                    hint: 'Select a class',
                    validator: (v) =>
                        review.reviewClass.validate().exceptionOrNull(),
                    onChanged: (dynamic e) {
                      review.setReviewClass(e!);

                      widget.studentBloc.add(
                        GetStudentByClassEvent(
                          classID: review.reviewClass.value,
                        ),
                      );

                      setState(() {
                        visibleList = true;
                      });
                    },
                    value: review.reviewClass.value,
                    items: classes
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.id.value,
                            child: Text(
                                '${e.name.value} / ${e.dayWeek.value} / ${e.schedule.value}'),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const Divider(),
              Visibility(
                visible: visibleList,
                child: BlocBuilder<StudentBloc, StudentStates>(
                  bloc: widget.studentBloc,
                  builder: (context, state) {
                    if (state is! SuccessGetStudentByClass) {
                      return const Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    final students = state.students;

                    if (students.isEmpty) {
                      return const Text('Students list empty');
                    }

                    return Column(
                      children: [
                        Visibility(
                          visible: visibleList,
                          child: MyInputWidget(
                            focusNode: fName,
                            hintText: 'Enter the number of the review',
                            label: 'Number',
                            onChanged: (e) =>
                                review.setReviewName(int.parse(e)),
                            validator: (v) =>
                                review.reviewName.validate().exceptionOrNull(),
                            value: review.reviewName.value == -1
                                ? ''
                                : review.reviewName.value.toString(),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Visibility(
                          visible: visibleList,
                          child: const SizedBox(height: 10),
                        ),
                        Visibility(
                          visible: visibleList,
                          child: MyInputWidget(
                            controller: dataController,
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now().add(
                                  const Duration(days: 365),
                                ),
                              );

                              if (selectedDate != null) {
                                review.setReviewDate(
                                    selectedDate.DiaMesAnoTextField());

                                dataController.text = review.reviewDate.value;
                              }
                            },
                            focusNode: fDate,
                            hintText: 'Enter the date of presence',
                            label: 'Date',
                            validator: (v) =>
                                review.reviewDate.validate().exceptionOrNull(),
                            readOnly: true,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final student = students[index];

                            return Container(
                              decoration: BoxDecoration(
                                color: makeBackGroundColorListTile(
                                  review.reviewNote[index].score.value,
                                  context,
                                ),
                                border: Border.all(
                                  color: review.reviewNote[index].score.value
                                          .isNotEmpty
                                      ? makeBackGroundColorListTile(
                                          review.reviewNote[index].score.value,
                                          context,
                                        )
                                      : ThemeModeController.themeMode ==
                                              ThemeMode.dark
                                          ? context.myTheme.onPrimary
                                          : context.myTheme.onPrimaryContainer,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(
                                  student.studentName.value,
                                  style: context.textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        ThemeModeController.themeMode ==
                                                ThemeMode.dark
                                            ? const Shadow(
                                                blurRadius: 10,
                                                offset: Offset(0, 1),
                                              )
                                            : const Shadow(),
                                      ]),
                                ),
                                trailing: SizedBox(
                                  width: 160,
                                  child: MyDropDownButtonWidget(
                                    border: false,
                                    validator: (v) => review
                                        .reviewNote[index].score
                                        .validate()
                                        .exceptionOrNull(),
                                    value: review.reviewNote[index].score.value,
                                    hint: 'Select the note',
                                    onChanged: (dynamic e) {
                                      review.reviewNote[index].setScore(e!);
                                      setState(() {});
                                    },
                                    items: notes
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e['type'],
                                            child: Text(
                                              e['name']!,
                                              style: context
                                                  .textTheme.bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                    ThemeModeController
                                                                .themeMode ==
                                                            ThemeMode.dark
                                                        ? const Shadow(
                                                            blurRadius: 10,
                                                            offset:
                                                                Offset(0, 1),
                                                          )
                                                        : const Shadow(),
                                                  ]),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 15),
                          itemCount: students.length,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: BlocBuilder<ReviewBloc, ReviewStates>(
                                bloc: widget.reviewBloc,
                                builder: (context, state) {
                                  return MyElevatedButtonWidget(
                                    label: state is LoadingReview
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text('Save'),
                                    icon: Icons.save_rounded,
                                    onPressed: () {
                                      if (!gkForm.currentState!.validate()) {
                                        return;
                                      }

                                      widget.reviewBloc.add(
                                        SaveReviewEvent(review: review),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
