// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:wizard/app/components/my_elevated_button_widget.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class HomePage extends StatefulWidget {
  final AuthBloc authBloc;

  const HomePage({
    Key? key,
    required this.authBloc,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User user;

  late StreamSubscription sub;

  @override
  void initState() {
    super.initState();

    user = GlobalUser.instance.user;

    sub = widget.authBloc.stream.listen((state) {
      if (state is SuccessLogoutAuth) {
        Modular.to.navigate('/auth');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        title: const Text('WizUp'),
        centerTitle: true,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppTheme.colors.primary),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: user.photoURL.value,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Teacher: ${user.name.value}',
                    style: AppTheme.textStyles.subTitleAppBar,
                  )
                ],
              ),
            ),
            SizedBox(
              height: context.screenHeight * .75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<AuthBloc, AuthStates>(
                      bloc: widget.authBloc,
                      builder: (context, state) {
                        if (state is LoadignAuth) {
                          return const Center(
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return ListTile(
                          title: const Text('Sair'),
                          onTap: () {
                            widget.authBloc.add(LogOutGoogleEvent());
                          },
                        );
                      }),
                  const ListTile(
                    title: Text(
                      'Versão 1.0.0',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                label: const Text('New Student'),
                icon: Icons.person_add_rounded,
                onPressed: () {
                  Modular.to.pushNamed('/home/student/edit');
                },
              ),
              MyElevatedButtonWidget(
                label: const Text('New Class'),
                icon: Icons.class_rounded,
                onPressed: () {
                  Modular.to.pushNamed('/home/class/edit');
                },
              ),
              MyElevatedButtonWidget(
                label: const Text('Mark Presence'),
                icon: Icons.mark_chat_read_rounded,
                onPressed: () {
                  Modular.to.pushNamed('/home/presence/');
                },
              ),
              MyElevatedButtonWidget(
                label: const Text('Note by Homework '),
                icon: Icons.note_alt_rounded,
                onPressed: () {
                  Modular.to.pushNamed('/home/homeWork/');
                },
              ),
              MyElevatedButtonWidget(
                label: const Text('Note by Review'),
                icon: Icons.reviews_rounded,
                onPressed: () {
                  Modular.to.pushNamed('/home/review/');
                },
              ),
              MyElevatedButtonWidget(
                label: const Text('General Report'),
                icon: Icons.newspaper_rounded,
                onPressed: () {
                  Modular.to.pushNamed('/home/report');
                },
              ),
              MyElevatedButtonWidget(
                label: const Text('Student List'),
                icon: Icons.list_rounded,
                onPressed: () {
                  Modular.to.pushNamed('/home/student/');
                },
              ),
              MyElevatedButtonWidget(
                label: const Text('Class List'),
                icon: Icons.list_rounded,
                onPressed: () {
                  Modular.to.pushNamed('/home/class');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
