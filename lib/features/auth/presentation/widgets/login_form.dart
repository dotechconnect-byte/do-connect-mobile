import 'package:do_connect/core/widgets/custom_text_field.dart';
import 'package:do_connect/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';


class LoginForm extends StatefulWidget {
  final String accountType;

  const LoginForm({super.key, required this.accountType});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement BLoC login logic
      final email = _emailController.text;
      final password = _passwordController.text;
      final accountType = widget.accountType;

      print('Login attempt:');
      print('Email: $email');
      print('Account Type: $accountType');

      // BLoC event dispatch example:
      // context.read<AuthBloc>().add(
      //   LoginRequested(
      //     email: email,
      //     password: password,
      //     accountType: accountType,
      //   ),
      // );
    }
  }

  void _handleForgotPassword() {
    // TODO: Navigate to forgot password screen
    print('Forgot password tapped');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email Field
          Text(
            'Email',
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ).copyWith(fontSize: (size.width * 0.04).clamp(14.0, 18.0)),
          ),
          SizedBox(height: size.height * 0.01),
          CustomTextField(
            controller: _emailController,
            hintText:
                widget.accountType == 'Personal'
                    ? 'your@email.com'
                    : 'employer@company.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          SizedBox(height: size.height * 0.025),

          // Password Field
          Text(
            'Password',
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ).copyWith(fontSize: (size.width * 0.04).clamp(14.0, 18.0)),
          ),
          SizedBox(height: size.height * 0.01),
          CustomTextField(
            controller: _passwordController,
            hintText: '••••••••',
            prefixIcon: Icons.lock_outlined,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),

          SizedBox(height: size.height * 0.03),

          // Sign In Button
          PrimaryButton(text: 'Sign In', onPressed: _handleLogin),

          SizedBox(height: size.height * 0.02),

          // Forgot Password Link
          Center(
            child: TextButton(
              onPressed: _handleForgotPassword,
              child: Text(
                'Forgot password?',
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  color: const Color(0xFFFF7A29),
                  fontWeight: FontWeight.w600,
                ).copyWith(fontSize: (size.width * 0.04).clamp(14.0, 16.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
