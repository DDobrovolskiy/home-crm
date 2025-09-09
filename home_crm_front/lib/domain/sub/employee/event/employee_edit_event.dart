

class EmployeeEditEvent {
  int? id;
  String? name;
  String? phone;
  String? password;
  int? roleId;

  EmployeeEditEvent({
    this.id,
    this.name,
    this.phone,
    this.password,
    this.roleId,
  });
}