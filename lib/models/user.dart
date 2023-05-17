class UserModel {
  int id;
  String login;
  String password;
  int roleId;
  String lastName;
  String firstName;
  String middleName;
  int groupId;
  String phone;
  String email;

  UserModel({
    required this.id,
    required this.login,
    required this.password,
    required this.roleId,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.groupId,
    required this.phone,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
      id: parsedJson['id'],
      login: parsedJson['login'],
      password: parsedJson['password'],
      roleId: parsedJson['roleId'],
      lastName: parsedJson['lastName'],
      firstName: parsedJson['firstName'],
      middleName: parsedJson['middleName'],
      groupId: parsedJson['groupId'],
      phone: parsedJson['phone'],
      email: parsedJson['email'],
    );
  }
}
