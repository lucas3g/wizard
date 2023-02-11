// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:wizard/app/utils/constants.dart';

class MyDrawerWidget extends StatelessWidget {
  final AuthBloc authBloc;
  final User user;

  const MyDrawerWidget({
    Key? key,
    required this.authBloc,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: context.screenHeight * .30,
            child: DrawerHeader(
              decoration: BoxDecoration(color: context.myTheme.onPrimary),
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
                BlocBuilder<AuthBloc, AuthStates>(
                    bloc: authBloc,
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
                          authBloc.add(LogOutGoogleEvent());
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
          ),
        ],
      ),
    );
  }
}
