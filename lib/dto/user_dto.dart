import 'package:json_annotation/json_annotation.dart';
import 'package:turbo_firestore_api/turbo_firestore_api.dart';
import 'package:turbo_modules/firebase/converters/timestamp_converter.dart';
import 'package:turbo_serializable/abstracts/t_writeable_id.dart';

part 'user_dto.g.dart';

@JsonSerializable(
  includeIfNull: true,
  explicitToJson: true,
)
class UserDto extends TWriteableId {
  UserDto({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDto.defaultLocalValue(TVars vars) => UserDto(
    id: vars.defaultIdValue,
    createdAt: vars.now,
    updatedAt: vars.now,
  );

  factory UserDto.defaultRemoteValue(TVars vars) => UserDto(
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

  static const fromJsonFactory = _$UserDtoFromJson;
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  static const toJsonFactory = _$UserDtoToJson;
  @override
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  // TODO(appboy): Add copyWith
  // TODO(appboy): Add toString
}
