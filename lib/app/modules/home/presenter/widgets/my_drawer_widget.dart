// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:wizard/app/shared/stores/app_store.dart';
import 'package:wizard/app/utils/constants.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyDrawerWidget extends StatefulWidget {
  final AuthBloc authBloc;
  final User user;

  const MyDrawerWidget({
    Key? key,
    required this.authBloc,
    required this.user,
  }) : super(key: key);

  @override
  State<MyDrawerWidget> createState() => _MyDrawerWidgetState();
}

class _MyDrawerWidgetState extends State<MyDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>(
      (store) => store.themeMode,
    );

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: context.screenHeight * .30,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: appStore.themeMode.value == ThemeMode.dark
                    ? context.myTheme.onPrimary
                    : context.myTheme.onPrimaryContainer,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: widget.user.photoURL.value,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Teacher: ${widget.user.name.value}',
                    style: context.textTheme.titleSmall,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: context.screenHeight * .70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  minLeadingWidth: 2,
                  leading: Icon(
                    appStore.themeMode.value == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    color: context.myTheme.onBackground,
                  ),
                  title: Text(
                    appStore.themeMode.value == ThemeMode.dark
                        ? 'Dark'
                        : 'Light',
                  ),
                  onTap: () {
                    appStore.changeThemeMode(
                      appStore.themeMode.value == ThemeMode.dark
                          ? ThemeMode.light
                          : ThemeMode.dark,
                    );
                  },
                ),
                Column(
                  children: [
                    StreamBuilder<AuthStates>(
                        stream: widget.authBloc.stream,
                        builder: (context, state) {
                          return ListTile(
                            minLeadingWidth: 2,
                            leading: Icon(
                              Icons.exit_to_app_rounded,
                              color: context.myTheme.onBackground,
                            ),
                            title: state is LoadignAuth
                                ? Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: context.myTheme.onBackground,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Text('Sair'),
                            onTap: () {
                              widget.authBloc.add(LogOutGoogleEvent());
                            },
                          );
                        }),
                    ListTile(
                      title: Text(
                        'Versão 1.0.0',
                        textAlign: TextAlign.end,
                        style: context.textTheme.labelSmall,
                      ),
                      subtitle: Text(
                        'MakTub Company - 2023',
                        textAlign: TextAlign.center,
                        style: context.textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
