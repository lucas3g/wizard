import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/shared/stores/app_store.dart';
import 'package:wizard/app/utils/constants.dart';

class MyAppBarWidget extends StatefulWidget {
  final String titleAppbar;
  const MyAppBarWidget({
    Key? key,
    required this.titleAppbar,
  }) : super(key: key);

  @override
  State<MyAppBarWidget> createState() => _MyAppBarWidgetState();
}

class _MyAppBarWidgetState extends State<MyAppBarWidget> {
  final height = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    final appStore = context.watch<AppStore>(
      (store) => store.themeMode,
    );

    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      title: Text(
        widget.titleAppbar,
        style: context.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: appStore.themeMode.value == ThemeMode.dark
              ? context.myTheme.onBackground
              : context.myTheme.background,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Modular.to.pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
