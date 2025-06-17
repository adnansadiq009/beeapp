class SigninRequest {
  final String email;
  final String password;

  SigninRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class SignupRequest {
  final String password;
  final String name;
  final String phoneNumber;
  final String email;
  final String image; // optional, default empty string if not used

  SignupRequest({
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.image = "",
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'token': {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'image': image,
      }
    };
  }
}
