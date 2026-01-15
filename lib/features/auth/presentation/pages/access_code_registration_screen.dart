import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';

class AccessCodeRegistrationScreen extends StatefulWidget {
  const AccessCodeRegistrationScreen({super.key});

  @override
  State<AccessCodeRegistrationScreen> createState() =>
      _AccessCodeRegistrationScreenState();
}

class _AccessCodeRegistrationScreenState
    extends State<AccessCodeRegistrationScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _accessCodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _positionController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _acceptTerms = false;
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _accessCodeController.dispose();
    _nameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _positionController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleCreateProfile() {
    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please accept Terms and Conditions',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                color: ColorManager.white,
              ),
            ),
            backgroundColor: ColorManager.error,
          ),
        );
        return;
      }

      setState(() => _isLoading = true);

      // TODO: Implement actual registration logic
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profile created successfully!',
              style: FontConstants.getPoppinsStyle(
                fontSize: FontSize.s14,
                color: ColorManager.white,
              ),
            ),
            backgroundColor: ColorManager.success,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Back to Login',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s15,
            fontWeight: FontWeightManager.medium,
            color: colors.textSecondary,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 24.h),

                    // Logo
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorManager.primary,
                            ColorManager.primaryLight,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.primary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'D',
                          style: FontConstants.getPoppinsStyle(
                            fontSize: FontSize.s28,
                            fontWeight: FontWeightManager.bold,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Text(
                      'Create Profile',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s26,
                        fontWeight: FontWeightManager.bold,
                        color: colors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      'Sign up with your access code',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textSecondary,
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Access Code
                          AuthTextField(
                            label: 'Access Code',
                            hintText: 'Enter your access code',
                            prefixIcon: Icons.key_outlined,
                            controller: _accessCodeController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter access code';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          // Name
                          AuthTextField(
                            label: 'Name',
                            hintText: 'Your full name',
                            prefixIcon: Icons.person_outline,
                            controller: _nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          // Contact Number
                          AuthTextField(
                            label: 'Contact Number',
                            hintText: 'Your contact number',
                            prefixIcon: Icons.phone_outlined,
                            controller: _contactController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter contact number';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          // Email
                          AuthTextField(
                            label: 'Email',
                            hintText: 'your@email.com',
                            prefixIcon: Icons.email_outlined,
                            controller: _emailController,
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

                          SizedBox(height: 16.h),

                          // Position
                          AuthTextField(
                            label: 'Position',
                            hintText: 'Your position',
                            prefixIcon: Icons.work_outline,
                            controller: _positionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your position';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          // Password
                          AuthTextField(
                            label: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            obscureText: !_isPasswordVisible,
                            controller: _passwordController,
                            onTogglePassword: () {
                              setState(() => _isPasswordVisible = !_isPasswordVisible);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          // Confirm Password
                          AuthTextField(
                            label: 'Confirm Password',
                            hintText: 'Confirm your password',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            obscureText: !_isConfirmPasswordVisible,
                            controller: _confirmPasswordController,
                            onTogglePassword: () {
                              setState(() =>
                                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 20.h),

                          // Terms and Conditions
                          Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: Checkbox(
                                  value: _acceptTerms,
                                  onChanged: (value) {
                                    setState(() => _acceptTerms = value ?? false);
                                  },
                                  activeColor: ColorManager.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Wrap(
                                  children: [
                                    Text(
                                      'I accept the ',
                                      style: FontConstants.getPoppinsStyle(
                                        fontSize: FontSize.s13,
                                        fontWeight: FontWeightManager.regular,
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // TODO: Show terms
                                      },
                                      child: Text(
                                        'Terms and Conditions',
                                        style: FontConstants.getPoppinsStyle(
                                          fontSize: FontSize.s13,
                                          fontWeight: FontWeightManager.semiBold,
                                          color: ColorManager.primary,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      ' and ',
                                      style: FontConstants.getPoppinsStyle(
                                        fontSize: FontSize.s13,
                                        fontWeight: FontWeightManager.regular,
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // TODO: Show privacy policy
                                      },
                                      child: Text(
                                        'Privacy Policy',
                                        style: FontConstants.getPoppinsStyle(
                                          fontSize: FontSize.s13,
                                          fontWeight: FontWeightManager.semiBold,
                                          color: ColorManager.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.h),

                          // Create Profile Button
                          AuthButton(
                            text: 'Create Profile',
                            onPressed: _handleCreateProfile,
                            isLoading: _isLoading,
                          ),

                          SizedBox(height: 16.h),

                          // Forgot Password Link
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                // TODO: Navigate to forgot password
                              },
                              child: Text(
                                'Forgot password?',
                                style: FontConstants.getPoppinsStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeightManager.semiBold,
                                  color: ColorManager.primary,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 32.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
