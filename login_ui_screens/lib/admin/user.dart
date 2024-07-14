class UserData {
  final String email;
  final String password;
  final String timestamp;

  UserData({
    required this.email,
    required this.password,
    required this.timestamp,
  });

  factory UserData.fromMap(Map<String, dynamic> map) => UserData(
        email: map['email'] as String,
        password: map['password'] as String,
        timestamp: map['timestamp'] as String,
      );
}
