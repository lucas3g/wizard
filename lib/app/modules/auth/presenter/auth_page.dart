import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/components/my_input_widget.dart';
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

  Future initLogin() async {
    if (!gkForm.currentState!.validate()) {
      return;
    }
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
            Form(
              key: gkForm,
              child: ListView(
                shrinkWrap: true,
                children: [
                  MyInputWidget(
                    focusNode: fUser,
                    hintText: 'Type your username',
                    label: 'Username',
                    textEditingController: userController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyInputWidget(
                    obscureText: !visiblePassword,
                    focusNode: fPassword,
                    hintText: 'Type your password',
                    label: 'Password',
                    textEditingController: passwordController,
                    maxLines: 1,
                    suffixIcon: GestureDetector(
                      child: Icon(
                        !visiblePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 25,
                        color: !visiblePassword
                            ? const Color(0xFF666666)
                            : AppTheme.colors.primary,
                      ),
                      onTap: () {
                        visiblePassword = !visiblePassword;
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () async {
                              await initLogin();
                            },
                            child: const Text('Sign In'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppTheme.textStyles.textRegister,
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                        child: const Text('Register here'),
                        onPressed: () {
                          Modular.to.navigate('./register/');
                        },
                      ),
                    ],
                  ),
                ],
              ),
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
