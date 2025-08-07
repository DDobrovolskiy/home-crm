import 'package:json_annotation/json_annotation.dart';

part 'fail_dto.g.dart';

@JsonSerializable()
class Fail {
  final String event;
  final String message;

  Fail({required this.event, required this.message});

  Map<String, dynamic> toJson() {
    return _$FailToJson(this);
  }

  factory Fail.fromJson(Map<String, dynamic> json) => _$FailFromJson(json);
}
