// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/core_module/services/shared_preferences/adapters/shared_params.dart';
import 'package:wizard/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:wizard/app/modules/auth/infra/adapters/user_adapter.dart';

import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class AuthPage extends StatefulWidget {
  final AuthBloc authBloc;

  const AuthPage({
    Key? key,
    required this.authBloc,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late StreamSubscription sub;

  Future initLogin() async {
    widget.authBloc.add(SignInGoogleEvent());
  }

  @override
  void initState() {
    super.initState();

    sub = widget.authBloc.stream.listen((state) async {
      if (state is SuccessAuth) {
        final shared = Modular.get<ILocalStorage>();

        await shared.setData(
          params: SharedParams(
            key: 'user',
            value: UserAdapter.toJson(state.user),
          ),
        );

        Modular.to.pushReplacementNamed('/home/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: context.screenWidth * .3,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Wizard',
                        style: AppTheme.textStyles.titleSplash,
                      ),
                      TextSpan(
                        text: '\n  by pearson',
                        style: AppTheme.textStyles.subtitleSplash,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              'Welcome to the Teacher Control Wizup',
              style: AppTheme.textStyles.titleAuthPage,
              textAlign: TextAlign.center,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Log in with a google account :)',
                  style: AppTheme.textStyles.subTitleAuthPage,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: InkWell(
                          onTap: () async {
                            await initLogin();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  Image.asset('assets/images/google.png'),
                                  const VerticalDivider(
                                    color: Colors.grey,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Login with google',
                                      style:
                                          AppTheme.textStyles.labelButtonGoogle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(),
            Text(
              'Wizard 2022',
              style: AppTheme.textStyles.subtitleSplash,
            ),
          ],
        ),
      ),
    );
  }
}
