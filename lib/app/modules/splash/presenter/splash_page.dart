import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/app_module.dart';
import 'package:wizard/app/core_module/constants/constants.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late GlobalUser globalUser;

  Future init() async {
    await Future.delayed(const Duration(seconds: 2));

    await Modular.isModuleReady<AppModule>();

    globalUser = GlobalUser();

    if (globalUser.user.name.value.isNotEmpty) {
      Modular.to.navigate('/home/');
      return;
    }

    Modular.to.navigate('/auth/');
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: context.screenWidth * .4,
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
          ],
        ),
      ),
    );
  }
}
