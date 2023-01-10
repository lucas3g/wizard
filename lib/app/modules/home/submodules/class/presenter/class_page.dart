// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_elevated_button_widget.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/events/class_events.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/states/class_states.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class ClassPage extends StatefulWidget {
  final ClassBloc classBloc;

  const ClassPage({
    Key? key,
    required this.classBloc,
  }) : super(key: key);

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    widget.classBloc.add(
      GetClassesByIdTeacher(
        idTeacher: ClassIDTeacher(GlobalUser.instance.user.id.value),
      ),
    );

    sub = widget.classBloc.stream.listen((state) {
      if (state is ErrorClass) {
        MySnackBar(message: state.message, type: TypeSnackBar.error);
      }
    });
  }

  @override
  void dispose() {
    sub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, AppBar().preferredSize.height),
        child: const MyAppBarWidget(titleAppbar: 'Class List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: BlocBuilder<ClassBloc, ClassStates>(
            bloc: widget.classBloc,
            builder: (context, state) {
              if (state is ErrorClass) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child: Text('Try fetching the data again.')),
                    SizedBox(
                      width: 150,
                      child: MyElevatedButtonWidget(
                        label: const Text('Try fetching'),
                        icon: Icons.refresh,
                        onPressed: () {
                          widget.classBloc.add(
                            GetClassesByIdTeacher(
                              idTeacher: ClassIDTeacher(
                                  GlobalUser.instance.user.id.value),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              if (state is! SuccessGetListClass) {
                return const Center(child: CircularProgressIndicator());
              }

              final classes = state.classes;

              if (classes.isEmpty) {
                return const Center(
                  child: Text('Class list is empty :('),
                );
              }

              return ListView.separated(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  final pClass = classes[index];

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
                      key: ObjectKey(pClass),
                      trailingActions: <SwipeAction>[
                        SwipeAction(
                          widthSpace: 90,
                          backgroundRadius: 10,
                          style: AppTheme.textStyles.labelRemoveSwipeAction,
                          title: "Remove",
                          onTap: (CompletionHandler handler) async {
                            classes.removeAt(index);
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
                              '/home/class/edit',
                              arguments: pClass,
                            );

                            widget.classBloc.add(
                              GetClassesByIdTeacher(
                                idTeacher: ClassIDTeacher(
                                    GlobalUser.instance.user.id.value),
                              ),
                            );
                          },
                          color: Colors.orange,
                        ),
                      ],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          pClass.name.value,
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
