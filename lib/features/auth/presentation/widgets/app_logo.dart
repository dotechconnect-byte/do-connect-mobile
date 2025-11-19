// lib/features/auth/presentation/widgets/app_logo.dart

import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width * 0.25,
          height: size.width * 0.25,
          constraints: const BoxConstraints(
            minWidth: 80,
            minHeight: 80,
            maxWidth: 120,
            maxHeight: 120,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFF7A29),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF7A29).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'D',
              style: TextStyle(
                fontSize: size.width * 0.12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ).copyWith(fontSize: (size.width * 0.12).clamp(40.0, 60.0)),
            ),
          ),
        ),
        SizedBox(height: size.height * 0.02),
        Text(
          'Do Connect',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: size.height * 0.005),
        Text(
          'Staff Management Portal',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
