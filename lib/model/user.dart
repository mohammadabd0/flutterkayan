class User {
  String? userId;
  String? userName;
  String? email;
  String? password;

  User({this.userId, this.userName, this.email, this.password});

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userName": userName,
      "email": email,
      "password": password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
    );
  }
  String get getuserName {
    return userName!;
  }

  String get getEmail {
    return email!;
  }
}
