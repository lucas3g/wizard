// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/states/auth_states.dart';
import 'package:wizard/app/modules/home/presenter/widgets/list_card_meu_widget.dart';
import 'package:wizard/app/modules/home/presenter/widgets/my_drawer_widget.dart';
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
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.menu,
            ),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      drawer: MyDrawerWidget(authBloc: widget.authBloc, user: user),
      body: const Padding(
        padding: EdgeInsets.all(10),
        child: ListCardMenuWidget(),
      ),
    );
  }
}
