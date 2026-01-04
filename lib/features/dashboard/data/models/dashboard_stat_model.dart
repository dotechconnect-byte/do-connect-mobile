import 'package:flutter/material.dart';

class DashboardStatModel {
  final String title;
  final String value;
  final String change;
  final bool isPositive;
  final IconData icon;
  final Color iconColor;

  DashboardStatModel({
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
    required this.icon,
    required this.iconColor,
  });

  // For API integration
  factory DashboardStatModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatModel(
      title: json['title'] ?? '',
      value: json['value'] ?? '0',
      change: json['change'] ?? '0%',
      isPositive: json['isPositive'] ?? true,
      icon: Icons.analytics, // Default, can be mapped from string
      iconColor: Colors.orange, // Default
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'change': change,
      'isPositive': isPositive,
    };
  }
}

class TopPerformerModel {
  final String name;
  final String hoursWorked;
  final double rating;

  TopPerformerModel({
    required this.name,
    required this.hoursWorked,
    required this.rating,
  });

  factory TopPerformerModel.fromJson(Map<String, dynamic> json) {
    return TopPerformerModel(
      name: json['name'] ?? '',
      hoursWorked: json['hoursWorked'] ?? '0h',
      rating: (json['rating'] ?? 0.0).toDouble(),
    );
  }
}

class ShiftModel {
  final String date;
  final String time;
  final String location;
  final String position;
  final String assignedTo;
  final String status;

  ShiftModel({
    required this.date,
    required this.time,
    required this.location,
    required this.position,
    required this.assignedTo,
    required this.status,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      location: json['location'] ?? '',
      position: json['position'] ?? '',
      assignedTo: json['assignedTo'] ?? '',
      status: json['status'] ?? 'pending',
    );
  }
}

class PositionDistributionModel {
  final String position;
  final int count;
  final Color color;

  PositionDistributionModel({
    required this.position,
    required this.count,
    required this.color,
  });

  factory PositionDistributionModel.fromJson(Map<String, dynamic> json) {
    return PositionDistributionModel(
      position: json['position'] ?? '',
      count: json['count'] ?? 0,
      color: Color(int.parse(json['color'] ?? '0xFFFF6B35')),
    );
  }
}
