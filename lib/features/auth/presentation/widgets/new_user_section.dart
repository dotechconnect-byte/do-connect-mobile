import 'package:do_connect/features/auth/presentation/pages/signup_screen.dart';
import 'package:flutter/material.dart';

class NewUserSection extends StatelessWidget {
  const NewUserSection({super.key});

  void _handleGetDemo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(
          signupType: SignupType.demo,
        ),
      ),
    );
  }

  void _handleCreateProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(
          signupType: SignupType.accessCode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(size.width * 0.06),
      child: Column(
        children: [
          Text(
            'New to Do Connect?',
            style: TextStyle(
              fontSize: size.width * 0.055,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ).copyWith(
              fontSize: (size.width * 0.055).clamp(20.0, 26.0),
            ),
          ),
          SizedBox(height: size.height * 0.025),

          // Get Free Demo Button
          _OutlineButton(
            text: 'Get Free Demo',
            onPressed: () => _handleGetDemo(context),
          ),

          SizedBox(height: size.height * 0.015),

          // OR Divider
          Row(
            children: [
              const Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: size.width * 0.035,
                  ),
                ),
              ),
              const Expanded(child: Divider()),
            ],
          ),

          SizedBox(height: size.height * 0.015),

          // Create Profile Link
          TextButton(
            onPressed: () => _handleCreateProfile(context),
            child: Text(
              'Create Profile with Access Code',
              style: TextStyle(
                fontSize: size.width * 0.04,
                color: const Color(0xFFFF7A29),
                fontWeight: FontWeight.w600,
              ).copyWith(
                fontSize: (size.width * 0.04).clamp(14.0, 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _OutlineButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.06,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Colors.grey[300]!,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ).copyWith(
            fontSize: (size.width * 0.04).clamp(14.0, 18.0),
          ),
        ),
      ),
    );
  }
}
