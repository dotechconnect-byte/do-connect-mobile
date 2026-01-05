import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';
import '../widgets/account_type_selector.dart';
import 'get_demo_screen.dart';
import 'access_code_registration_screen.dart';
import '../../../home/presentation/pages/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _accountType = 'personal';
  bool _isPasswordVisible = false;
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // TODO: Implement actual sign in logic with API
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        setState(() => _isLoading = false);

        // Navigate to Home Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      });
    }
  }

  void _navigateToForgotPassword() {
    // TODO: Navigate to forgot password screen
  }

  void _navigateToGetDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GetDemoScreen(),
      ),
    );
  }

  void _navigateToAccessCode() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AccessCodeRegistrationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = ThemeHelper.of(context);

    return Scaffold(
      backgroundColor: colors.background,
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
                    SizedBox(height: 40.h),

                    // Modern Minimal Logo
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
                      'Do Connect',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s28,
                        fontWeight: FontWeightManager.bold,
                        color: colors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      'Staff Management Portal',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textSecondary,
                      ),
                    ),

                    SizedBox(height: 48.h),

                    // Main Form Section
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome Back',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s26,
                              fontWeight: FontWeightManager.bold,
                              color: colors.textPrimary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Sign in to continue',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s15,
                              fontWeight: FontWeightManager.regular,
                              color: colors.textSecondary,
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // Account Type Selector
                          AccountTypeSelector(
                            selectedType: _accountType,
                            onTypeChanged: (type) {
                              setState(() => _accountType = type);
                            },
                          ),

                          SizedBox(height: 24.h),

                          // Email Field
                          AuthTextField(
                            label: 'Email',
                            hintText: _accountType == 'personal'
                                ? 'your@email.com'
                                : 'employer@company.com',
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

                          SizedBox(height: 20.h),

                          // Password Field
                          AuthTextField(
                            label: 'Password',
                            hintText: '••••••••',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            obscureText: !_isPasswordVisible,
                            controller: _passwordController,
                            onTogglePassword: () {
                              setState(() => _isPasswordVisible = !_isPasswordVisible);
                            },
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

                          SizedBox(height: 12.h),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: _navigateToForgotPassword,
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

                          // Sign In Button
                          AuthButton(
                            text: 'Sign In',
                            onPressed: _handleSignIn,
                            isLoading: _isLoading,
                          ),

                          SizedBox(height: 40.h),

                          // Divider with Text
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        colors.grey3,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text(
                                  'or',
                                  style: FontConstants.getPoppinsStyle(
                                    fontSize: FontSize.s13,
                                    fontWeight: FontWeightManager.medium,
                                    color: colors.textSecondary,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        colors.grey3,
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 40.h),

                          // New User Section Title
                          Center(
                            child: Text(
                              'New to Do Connect?',
                              style: FontConstants.getPoppinsStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.semiBold,
                                color: colors.textPrimary,
                              ),
                            ),
                          ),

                          SizedBox(height: 24.h),

                          // Get Free Demo Button
                          Container(
                            width: double.infinity,
                            height: 56.h,
                            decoration: BoxDecoration(
                              color: colors.grey6,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: colors.grey4,
                                width: 1.5,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _navigateToGetDemo,
                                borderRadius: BorderRadius.circular(14.r),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.play_circle_outline,
                                        color: colors.textPrimary,
                                        size: 22.sp,
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        'Get Free Demo',
                                        style: FontConstants.getPoppinsStyle(
                                          fontSize: FontSize.s15,
                                          fontWeight: FontWeightManager.semiBold,
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          // Access Code Button
                          Container(
                            width: double.infinity,
                            height: 56.h,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorManager.primary.withValues(alpha: 0.08),
                                  ColorManager.primaryLight.withValues(alpha: 0.08),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: ColorManager.primary.withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: _navigateToAccessCode,
                                borderRadius: BorderRadius.circular(14.r),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.key_outlined,
                                        color: ColorManager.primary,
                                        size: 22.sp,
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        'Create with Access Code',
                                        style: FontConstants.getPoppinsStyle(
                                          fontSize: FontSize.s15,
                                          fontWeight: FontWeightManager.semiBold,
                                          color: ColorManager.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 40.h),
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
