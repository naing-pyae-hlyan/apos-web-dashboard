enum UserRole {
  superAdmin("Super Admin"), // 1
  manager("Manager"), // 2
  normalUser("User"); // 0

  final String label;
  const UserRole(this.label);
}

UserRole parseUserRole(int role) => role == 1
    ? UserRole.superAdmin
    : role == 2
        ? UserRole.manager
        : UserRole.normalUser;

class UserModel {
  String? id;
  final String readableId;
  final String username;
  final String email;
  final String password;
  final int role;
  UserRole userRole;
  UserModel({
    this.id,
    required this.readableId,
    required this.email,
    required this.username,
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
