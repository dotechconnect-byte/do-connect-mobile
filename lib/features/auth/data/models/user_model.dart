// lib/features/auth/data/models/user_model.dart

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.accountType,
    super.name,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      accountType: json['account_type'] as String,
      name: json['name'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'account_type': accountType,
      'name': name,
      'token': token,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      accountType: accountType,
      name: name,
      token: token,
    );
  }
}
