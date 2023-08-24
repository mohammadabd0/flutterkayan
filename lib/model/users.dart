class Users {
  Users({
    required this.id,
    required this.email,
    required this.username,
  });

  late String email;
  late String id;
  late String username;

  Users.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? '';
    username = json['username'] ?? '';
    id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['username'] = username;
    return data;
  }
}