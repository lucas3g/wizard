import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/core_module/constants/constants.dart';

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

  late GlobalUser globalUser;

  @override
  void initState() {
    super.initState();

    globalUser = GlobalUser();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      title: Text(widget.titleAppbar),
      leading: IconButton(
        onPressed: () {
          Modular.to.pop();
        },
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
      ),
    );
  }
}
