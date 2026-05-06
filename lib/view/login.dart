import 'package:flutter/material.dart';
import 'package:turbo_modules/layout/widgets/t_page.dart';
import 'package:turbo_mvvm/turbo_mvvm.dart';

import 'login_arguments.dart';
import 'login_view_model.dart';

class Login extends StatelessWidget {
  const Login({
    required this.arguments,
    super.key,
  });

  final LoginArguments arguments;

  @override
  Widget build(BuildContext context) => TViewModelBuilder<LoginViewModel>(
    argumentBuilder: () => arguments,
    builder: (context, model, isInitialised, child) => TPage(
      isInitialised: isInitialised,
      model: model,
      children: const [
        Center(
          child: Text('Login'),
        ),
      ],
    ),
    viewModelBuilder: () => LoginViewModel.locate,
  );
}
