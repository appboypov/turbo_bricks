import 'package:flutter/material.dart';
import 'package:turbo_mvvm/turbo_mvvm.dart';

class UserCard extends TViewModelWidget<HomeViewModel> {
  const UserCard({super.key}) : super(isReactive: false);

  @override
  Widget build(BuildContext context, HomeViewModel model) {
  }
}
