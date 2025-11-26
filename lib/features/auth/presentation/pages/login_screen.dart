import 'package:do_connect/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:do_connect/features/auth/presentation/bloc/auth_state.dart';
import 'package:do_connect/features/auth/presentation/widgets/account_type_selecter.dart';
import 'package:do_connect/features/auth/presentation/widgets/new_user_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/app_logo.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _selectedAccountType = 'Personal';

  void _onAccountTypeChanged(String type) {
    setState(() {
      _selectedAccountType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login successful!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Login failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
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
                horizontal: size.width * 0.05,
                vertical: size.height * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppLogo(),
                  SizedBox(height: size.height * 0.03),

                  // Login Form Card
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: (size.width * 0.055).clamp(20.0, 24.0),
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: size.height * 0.008),
                        Text(
                          'Sign in to your account',
                          style: TextStyle(
                            fontSize: (size.width * 0.035).clamp(13.0, 15.0),
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: size.height * 0.025),
                        AccountTypeSelector(
                          selectedType: _selectedAccountType,
                          onTypeChanged: _onAccountTypeChanged,
                        ),
                        SizedBox(height: size.height * 0.025),
                        LoginForm(accountType: _selectedAccountType),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.025),
                  const NewUserSection(),
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
