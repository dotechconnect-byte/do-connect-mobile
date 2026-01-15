class CompanyModel {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? logoUrl;

  CompanyModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.logoUrl,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String,
      logoUrl: json['logoUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'logoUrl': logoUrl,
    };
  }
}

class FeedbackCategory {
  final String title;
  final String icon;
  final double rating;
  final int reviewCount;
  final List<FeedbackReview> reviews;

  FeedbackCategory({
    required this.title,
    required this.icon,
    required this.rating,
    required this.reviewCount,
    this.reviews = const [],
  });
}

class FeedbackReview {
  final double rating;
  final String comment;
  final String date;

  FeedbackReview({
    required this.rating,
    required this.comment,
    required this.date,
  });
}

enum AccountType {
  employerPro,
  employerBasic,
  doer,
}

class UserRole {
  final String name;
  final String description;
  final List<String> permissions;

  UserRole({
    required this.name,
    required this.description,
    required this.permissions,
  });
}
