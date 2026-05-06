import 'package:flutter/material.dart';
import 'package:turbo_modules/layout/widgets/t_page.dart';
import 'package:turbo_mvvm/turbo_mvvm.dart';

import '{{viewName.snakeCase()}}_arguments.dart';
import '{{viewName.snakeCase()}}_view_model.dart';

class {{viewName.pascalCase()}} extends StatelessWidget {
  const {{viewName.pascalCase()}}({
    required this.arguments,
    super.key,
  });

  final {{viewName.pascalCase()}}Arguments arguments;

  @override
  Widget build(BuildContext context) => TViewModelBuilder<{{viewName.pascalCase()}}ViewModel>(
    argumentBuilder: () => arguments,
    builder: (context, model, isInitialised, child) => TPage(
      isInitialised: isInitialised,
      model: model,
      children: const [
        Center(
          child: Text('{{viewName.pascalCase()}}'),
        ),
      ],
    ),
    viewModelBuilder: () => {{viewName.pascalCase()}}ViewModel.locate,
  );
}
