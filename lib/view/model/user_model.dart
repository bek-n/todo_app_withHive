class UserModel {
  final String? username;
  final String? password;
  final String? avatar;

  final String? email;

  final String? phone;
  final List? likes;

  UserModel({
    required this.username,
    required this.password,
    this.avatar,
    required this.email,
    required this.phone,
    this.likes,
  });

  factory UserModel.fromJson(Map<String, dynamic>? data) {
    return UserModel(
      username: data?["username"],
      password: data?["password"],
      avatar: data?["avatar"],
      email: data?["email"],
      phone: data?["phone"],
      likes: data?["array"],
    );
  }

  toJson() {
    return {
      "username": username,
      "password": password,
      "avatar": avatar,
      "email": email,
      "phone": phone,
      if (likes != null)
        "likes": List<dynamic>.from(likes!.map((x) => x.toJson())),
    };
  }
}
