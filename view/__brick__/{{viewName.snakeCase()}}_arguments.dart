import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_modules/routing/abstracts/i_view_arguments.dart';

part '{{viewName.snakeCase()}}_arguments.g.dart';

@JsonSerializable(
  includeIfNull: true,
  explicitToJson: true,
)
class {{viewName.pascalCase()}}Arguments extends IViewArguments {
  {{viewName.pascalCase()}}Arguments({
    required this.origin,
  });

  final {{viewName.pascalCase()}}Origin origin;

  factory {{viewName.pascalCase()}}Arguments.fromJson(Map<String, dynamic> json) => _${{viewName.pascalCase()}}ArgumentsFromJson(json);
  @override
  Map<String, dynamic> toJson() => _${{viewName.pascalCase()}}ArgumentsToJson(this);
}
