import 'package:json_annotation/json_annotation.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto {
  final String name;
  final Set<int> ids;

  MessageDto({
    required this.name,
    required this.ids,
  });

  Map<String, dynamic> toJson() {
    return _$MessageDtoToJson(this);
  }

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);




}