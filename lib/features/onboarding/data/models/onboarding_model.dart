import 'package:flutter/material.dart';

class OnboardingModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> features;

  OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.features,
  });
}

// Onboarding data
List<OnboardingModel> onboardingPages = [
  OnboardingModel(
    title: 'Empowering the World to DO Better',
    subtitle: 'Just DO. See what DO can DO for you. DO together, grow together.',
    icon: Icons.trending_up_rounded,
    features: [
      'End-to-end workforce management in one platform',
      'AI-powered insights for better decision making',
      'Seamless integration from hiring to invoicing',
    ],
  ),
  OnboardingModel(
    title: 'Every Great Business Starts with DO',
    subtitle: 'From Manual to Magical. Let AI DO the work for you.',
    icon: Icons.check_circle_rounded,
    features: [
      'AI-driven workforce optimization and scheduling',
      'Intelligent task automation and assignment',
      'Smart analytics and predictive insights',
    ],
  ),
  OnboardingModel(
    title: 'Think Less. DO More',
    subtitle: 'Empowering every workforce, everywhere with intelligent coordination',
    icon: Icons.groups_rounded,
    features: [
      'Real-time attendance and availability tracking',
      'Automated roster management with DO Assist',
      'Seamless staff coordination and communication',
    ],
  ),
  OnboardingModel(
    title: 'Your Time, Your Terms, Your DO',
    subtitle: 'Work Smarter, Get Better with dynamic job marketplace',
    icon: Icons.work_rounded,
    features: [
      'Flexible job matching for full-time and casual work',
      'Instant booking and transparent payments',
      'Build your talent pool and scale on demand',
    ],
  ),
];
