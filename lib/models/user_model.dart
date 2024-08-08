enum UserRoleEnum {
  normalUser("User", 0), // 0
  manager("Manager", 1), // 1
  superAdmin("SuperAdmin", 2); // 2

  final String label;
  final int role;
  const UserRoleEnum(this.label, this.role);
}

UserRoleEnum parseUserRole(int role) => role == 2
    ? UserRoleEnum.superAdmin
    : role == 1
        ? UserRoleEnum.manager
        : UserRoleEnum.normalUser;

class UserModel {
  String? id;
  final String readableId;
  final String username;
  final String email;
  final String password;
  final int role;
  UserRoleEnum userRole;
  UserModel({
    this.id,
    required this.readableId,
    required this.username,
    required this.email,
    required this.password,
    required this.role,
    required this.userRole,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      readableId: json["id"],
      email: json["email"],
      username: json["username"],
      password: json["password"],
      role: json["role"] ?? 0,
      userRole: parseUserRole(json["role"] ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': readableId,
      'email': email,
      'username': username,
      'password': password,
      'role': role,
    };
  }
}
