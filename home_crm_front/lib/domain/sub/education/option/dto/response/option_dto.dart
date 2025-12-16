import 'package:json_annotation/json_annotation.dart';

part 'option_dto.g.dart';

@JsonSerializable()
class OptionDto {
  late int? id;
  late String text;
  late bool correct;

  OptionDto({
    this.id,
    required this.text,
    required this.correct,
  });

  Map<String, dynamic> toJson() {
    return _$OptionDtoToJson(this);
  }

  factory OptionDto.fromJson(Map<String, dynamic> json) =>
      _$OptionDtoFromJson(json);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionDto && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
