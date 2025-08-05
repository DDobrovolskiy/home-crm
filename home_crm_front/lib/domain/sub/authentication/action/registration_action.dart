import 'package:json_annotation/json_annotation.dart';

part 'registration_action.g.dart';

@JsonSerializable()
class RegistrationAction {
  final String phone;
  final String password;

  RegistrationAction({required this.phone, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'password': password,
    };
  }

  factory RegistrationAction.fromJson(Map<String, dynamic> json) =>
      _$RegistrationActionFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationActionToJson(this);
}