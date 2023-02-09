// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:wizard/app/modules/home/presenter/widgets/list_card_meu_widget.dart';
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
            SizedBox(
              height: context.screenHeight * .30,
              child: DrawerHeader(
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
            ),
            SizedBox(
              height: context.screenHeight * .70,
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
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: ListCardMenuWidget(),
      ),
    );
  }
}
