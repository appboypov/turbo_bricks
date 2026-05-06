import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_modules/routing/abstracts/i_view_arguments.dart';

part 'login_arguments.g.dart';

@JsonSerializable(
  includeIfNull: true,
  explicitToJson: true,
)
class LoginArguments extends IViewArguments {
  LoginArguments({
    required this.origin,
  });

  final LoginOrigin origin;

  factory LoginArguments.fromJson(Map<String, dynamic> json) => _$LoginArgumentsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LoginArgumentsToJson(this);
}
