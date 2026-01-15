class LoggedInUser {
  static String? accessToken;
  static String? refreshToken;

  // Add other user-related properties as needed
  final String? id;
  final String? email;
  final String? name;

  LoggedInUser({
    this.id,
    this.email,
    this.name,
  });

  // Factory constructor for creating a LoggedInUser from JSON
  factory LoggedInUser.fromJson(Map<String, dynamic> json) {
    return LoggedInUser(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
    );
  }

  // Method to convert LoggedInUser to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  // Static method to handle user login and store tokens
  static void login(Map<String, dynamic> data) {
    accessToken = data['access_token'] as String?;
    refreshToken = data['refresh_token'] as String?;
  }

  // Static method to handle user logout
  static void logout() {
    accessToken = null;
    refreshToken = null;
  }
}
