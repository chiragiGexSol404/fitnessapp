class User {
  final int? id;
  final String username;
  final String email;
  final String password;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  // Helper method to get display name
  String get displayName => username.isNotEmpty ? username : email.split('@').first;
  
  // Helper method to get initials
  String get initials {
    if (username.isNotEmpty) {
      return username.substring(0, 1).toUpperCase();
    } else if (email.isNotEmpty) {
      return email.substring(0, 1).toUpperCase();
    }
    return 'U';
  }
}
