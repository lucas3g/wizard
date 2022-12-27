import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final fUser = FocusNode();
  final fPassword = FocusNode();

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  final gkForm = GlobalKey<FormState>();

  late bool visiblePassword = false;

  late User user;

  Future initLogin() async {
    // if (!gkForm.currentState!.validate()) {
    //   return;
    // }

    Modular.to.pushReplacementNamed('/home/');
  }

  @override
  void initState() {
    super.initState();

    user = UserAdapter.empty();
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
                            onTap: () {},
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
                                        style: AppTheme
                                            .textStyles.labelButtonGoogle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Don't have an account?",
                //       style: AppTheme.textStyles.textRegister,
                //     ),
                //     const SizedBox(width: 5),
                //     TextButton(
                //       child: const Text('Register here'),
                //       onPressed: () {
                //         Modular.to.navigate('./register/');
                //       },
                //     ),
                //   ],
                // ),
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
