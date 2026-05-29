class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class RegisterParams {
  final String email;
  final String password;
  final String name;
  final String phone;
  final String avatar;

  RegisterParams({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.avatar,
  });
}
