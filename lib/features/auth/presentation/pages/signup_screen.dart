import 'package:do_connect/features/auth/presentation/widgets/signup_form.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  final SignupType signupType;

  const SignupScreen({
    super.key,
    required this.signupType,
  });

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F1E8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height - padding.top - padding.bottom,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: (size.width * 0.055).clamp(20.0, 24.0),
                          color: Colors.black87,
                        ),
                        SizedBox(width: size.width * 0.02),
                        Text(
                          'Back to Login',
                          style: TextStyle(
                            fontSize: (size.width * 0.035).clamp(13.0, 15.0),
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.025),

                  // Logo and Title
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.18,
                          height: size.width * 0.18,
                          constraints: const BoxConstraints(
                            minWidth: 65,
                            minHeight: 65,
                            maxWidth: 90,
                            maxHeight: 90,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF7A29),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF7A29).withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'D',
                              style: TextStyle(
                                fontSize: (size.width * 0.09).clamp(32.0, 45.0),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.015),
                        Text(
                          widget.signupType == SignupType.demo
                              ? 'Get Free Demo'
                              : 'Create Profile',
                          style: TextStyle(
                            fontSize: (size.width * 0.058).clamp(22.0, 28.0),
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: size.height * 0.004),
                        Text(
                          widget.signupType == SignupType.demo
                              ? 'Experience Do Connect in action'
                              : 'Sign up with your access code',
                          style: TextStyle(
                            fontSize: (size.width * 0.035).clamp(13.0, 14.5),
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.025),

                  // Signup Form Card
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 600),
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
                    padding: EdgeInsets.all(size.width * 0.05),
                    child: SignupForm(signupType: widget.signupType),
                  ),

                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum SignupType {
  demo,
  accessCode,
}
