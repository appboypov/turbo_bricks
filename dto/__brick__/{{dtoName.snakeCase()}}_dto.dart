import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_firestore_api/turbo_firestore_api.dart';
import 'package:turbo_modules/firebase/converters/timestamp_converter.dart';
import 'package:turbo_serializable/abstracts/t_writeable_id.dart';

part '{{dtoName.snakeCase()}}_dto.g.dart';

@JsonSerializable(
  includeIfNull: true,
  explicitToJson: true,
)
class {{dtoName.pascalCase()}}Dto extends TWriteableId {
  {{dtoName.pascalCase()}}Dto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory {{dtoName.pascalCase()}}Dto.defaultLocalValue(TVars vars) => {{dtoName.pascalCase()}}Dto(
    id: vars.defaultIdValue,
    createdAt: vars.now,
    updatedAt: vars.now,
  );

  factory {{dtoName.pascalCase()}}Dto.defaultRemoteValue(TVars vars) => {{dtoName.pascalCase()}}Dto(
    id: vars.userId!,
    createdAt: vars.now,
    updatedAt: vars.now,
  );

  @override
  final String id;
  @TimestampConverter()
  final DateTime createdAt;
  @TimestampConverter()
  final DateTime updatedAt;

  static const fromJsonFactory = _${{dtoName.pascalCase()}}DtoFromJson;
  factory {{dtoName.pascalCase()}}Dto.fromJson(Map<String, dynamic> json) => _${{dtoName.pascalCase()}}DtoFromJson(json);
  static const toJsonFactory = _${{dtoName.pascalCase()}}DtoToJson;
  @override
  Map<String, dynamic> toJson() => _${{dtoName.pascalCase()}}DtoToJson(this);

  // TODO(appboy): Add copyWith
  // TODO(appboy): Add toString
}
