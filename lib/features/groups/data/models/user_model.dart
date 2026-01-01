class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final double rating;
  final int shiftsCount;
  final List<String> tags; // favourite, priority, regular
  final String? group; // Favourites, Regulars, Priority, Ban List
  final bool isLiked;
  final bool isLoved;
  final bool isBanned;
  final String? whatsappNumber; // Optional WhatsApp number
  final String? availabilityStatus; // Available, Busy, Offline, etc.
  final String comments;
  final String avatarColor; // For avatar background

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.rating = 0.0,
    this.shiftsCount = 0,
    this.tags = const [],
    this.group,
    this.isLiked = false,
    this.isLoved = false,
    this.isBanned = false,
    this.whatsappNumber,
    this.availabilityStatus,
    this.comments = '',
    this.avatarColor = 'FFE5E5',
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    double? rating,
    int? shiftsCount,
    List<String>? tags,
    String? group,
    bool? isLiked,
    bool? isLoved,
    bool? isBanned,
    String? whatsappNumber,
    String? availabilityStatus,
    String? comments,
    String? avatarColor,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      rating: rating ?? this.rating,
      shiftsCount: shiftsCount ?? this.shiftsCount,
      tags: tags ?? this.tags,
      group: group ?? this.group,
      isLiked: isLiked ?? this.isLiked,
      isLoved: isLoved ?? this.isLoved,
      isBanned: isBanned ?? this.isBanned,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      comments: comments ?? this.comments,
      avatarColor: avatarColor ?? this.avatarColor,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      shiftsCount: json['shiftsCount'] as int? ?? 0,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      group: json['group'] as String?,
      isLiked: json['isLiked'] as bool? ?? false,
      isLoved: json['isLoved'] as bool? ?? false,
      isBanned: json['isBanned'] as bool? ?? false,
      whatsappNumber: json['whatsappNumber'] as String?,
      availabilityStatus: json['availabilityStatus'] as String?,
      comments: json['comments'] as String? ?? '',
      avatarColor: json['avatarColor'] as String? ?? 'FFE5E5',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'rating': rating,
      'shiftsCount': shiftsCount,
      'tags': tags,
      'group': group,
      'isLiked': isLiked,
      'isLoved': isLoved,
      'isBanned': isBanned,
      'whatsappNumber': whatsappNumber,
      'availabilityStatus': availabilityStatus,
      'comments': comments,
      'avatarColor': avatarColor,
    };
  }

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }

  bool get hasWhatsApp => whatsappNumber != null && whatsappNumber!.isNotEmpty;
}
