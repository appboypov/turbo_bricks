import 'package:flutter/material.dart';
import 'package:turbo_mvvm/turbo_mvvm.dart';

class {{widgetName.pascalCase()}} extends TViewModelWidget<{{parentModel.pascalCase()}}ViewModel> {
  const {{widgetName.pascalCase()}}({super.key}) : super(isReactive: false);

  @override
  Widget build(BuildContext context, {{parentModel.pascalCase()}}ViewModel model) {
  }
}
