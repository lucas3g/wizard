import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:wizard/app/modules/auth/submodules/register/presenter/widgets/address_widget.dart';
import 'package:wizard/app/modules/auth/submodules/register/presenter/widgets/authentication_widget.dart';
import 'package:wizard/app/modules/auth/submodules/register/presenter/widgets/personal_data_widget.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final pageController = PageController();
  late int currentPage = 0;
  late User user;

  final gkForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    user = UserAdapter.empty();
  }

  Future<void> nextPage() async {
    if (!gkForm.currentState!.validate()) {
      return;
    }

    if (currentPage < 2) {
      currentPage++;
      setState(() {});
      await pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      return;
    }

    if (user.password.toString() != user.confirmPassword.toString()) {
      MySnackBar(message: 'Passwords do not match');
      return;
    }

    Modular.to.navigate('/auth/');
  }

  Future<void> backPage() async {
    if (currentPage > 0) {
      currentPage--;
      setState(() {});
      await pageController.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: gkForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: PageView(
          controller: pageController,
          children: [
            PersonalDataWidget(user: user),
            AddresWidget(user: user),
            AuthenticationWidget(user: user),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, double.infinity),
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () async {
                  if (currentPage == 0) {
                    Modular.to.navigate('/auth/');
                  } else {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await backPage();
                  }
                },
                child: Text(currentPage == 0 ? 'Cancel' : 'Back'),
              ),
            ),
            Container(
              height: 50,
              width: 2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, double.infinity),
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () async {
                  await nextPage();
                },
                child: Text(currentPage != 2 ? 'Next' : 'Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
