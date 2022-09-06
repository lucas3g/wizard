import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/theme/app_theme.dart';

class AuthenticationWidget extends StatefulWidget {
  final Size sizeAppBar;
  const AuthenticationWidget({
    Key? key,
    required this.sizeAppBar,
  }) : super(key: key);

  @override
  State<AuthenticationWidget> createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  final fEmail = FocusNode();
  final fPassword = FocusNode();
  final fConfirmPass = FocusNode();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();

  final gkForm = GlobalKey<FormState>();

  late bool visiblePassword = false;
  late bool visibleConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: widget.sizeAppBar,
        child: const MyAppBarWidget(titleAppbar: 'Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              MyInputWidget(
                focusNode: fEmail,
                hintText: 'Type you E-mail',
                label: 'E-mail',
                campoVazio: 'E-mail cannot be empty',
                textEditingController: emailController,
                inputFormaters: [
                  FilteringTextInputFormatter.deny(
                    RegExp(r"\s\b|\b\s"),
                  )
                ],
              ),
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fPassword,
                hintText: 'Type you password',
                label: 'Password',
                campoVazio: 'Password cannot be empty',
                textEditingController: passwordController,
                obscureText: !visiblePassword,
                maxLines: 1,
                suffixIcon: GestureDetector(
                  child: Icon(
                    !visiblePassword ? Icons.visibility_off : Icons.visibility,
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
              const SizedBox(height: 10),
              MyInputWidget(
                focusNode: fConfirmPass,
                hintText: 'Type you confirm password',
                label: 'Confirm password',
                campoVazio: 'Confirm password cannot be empty',
                textEditingController: confirmPassController,
                obscureText: !visibleConfirmPassword,
                maxLines: 1,
                suffixIcon: GestureDetector(
                  child: Icon(
                    !visibleConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 25,
                    color: !visibleConfirmPassword
                        ? const Color(0xFF666666)
                        : AppTheme.colors.primary,
                  ),
                  onTap: () {
                    visibleConfirmPassword = !visibleConfirmPassword;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
