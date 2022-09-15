import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wizard/app/components/my_app_bar_widget.dart';
import 'package:wizard/app/components/my_input_widget.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/theme/app_theme.dart';
import 'package:wizard/app/utils/constants.dart';

class AuthenticationWidget extends StatefulWidget {
  final User user;
  const AuthenticationWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<AuthenticationWidget> createState() => _AuthenticationWidgetState();
}

class _AuthenticationWidgetState extends State<AuthenticationWidget> {
  late User user;

  final fEmail = FocusNode();
  final fPassword = FocusNode();
  final fConfirmPass = FocusNode();

  final gkForm = GlobalKey<FormState>();

  late bool visiblePassword = false;
  late bool visibleConfirmPassword = false;

  @override
  void initState() {
    super.initState();

    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: context.sizeAppbar,
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
                value: user.email.toString(),
                onChanged: user.setEmail,
                validator: (v) => user.email.validator(),
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
                value: user.password.toString(),
                onChanged: user.setPassword,
                validator: (v) => user.password.validator(),
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
                value: user.confirmPassword.toString(),
                onChanged: user.setConfirmPassword,
                validator: (v) => user.confirmPassword.validator(),
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
