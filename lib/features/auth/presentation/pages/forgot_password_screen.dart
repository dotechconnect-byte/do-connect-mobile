import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/consts/color_manager.dart';
import '../../../../core/consts/font_manager.dart';
import '../../../../core/utils/theme_helper.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

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
    super.dispose();
  }

  void _handleSendResetLink() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // TODO: Implement actual API call to send reset link
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _emailSent = true;
        });
      });
    }
  }

  void _handleResendLink() {
    setState(() {
      _emailSent = false;
      _isLoading = true;
    });

    // TODO: Implement actual API call to resend link
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _emailSent = true;
      });
    });
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

                    SizedBox(height: 24.h),

                    Text(
                      'Forgot Password',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s28,
                        fontWeight: FontWeightManager.bold,
                        color: colors.textPrimary,
                        letterSpacing: -0.5,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Text(
                      'Reset your Do Connect password',
                      style: FontConstants.getPoppinsStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.regular,
                        color: colors.textSecondary,
                      ),
                    ),

                    SizedBox(height: 48.h),

                    // Main Form Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: colors.cardBackground,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: colors.grey4,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: colors.textPrimary.withValues(alpha: 0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _emailSent
                          ? _buildSuccessContent(colors)
                          : _buildFormContent(colors),
                    ),

                    SizedBox(height: 32.h),

                    // Back to Login Link
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            size: 16.sp,
                            color: ColorManager.primary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Back to Login',
                            style: FontConstants.getPoppinsStyle(
                              fontSize: FontSize.s15,
                              fontWeight: FontWeightManager.semiBold,
                              color: ColorManager.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormContent(ThemeHelper colors) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password Reset',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s20,
              fontWeight: FontWeightManager.bold,
              color: colors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter your email to receive reset instructions',
            style: FontConstants.getPoppinsStyle(
              fontSize: FontSize.s14,
              fontWeight: FontWeightManager.regular,
              color: colors.textSecondary,
            ),
          ),

          SizedBox(height: 28.h),

          // Email Field
          AuthTextField(
            label: 'Email Address *',
            hintText: 'your@email.com',
            prefixIcon: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@') || !value.contains('.')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),

          SizedBox(height: 28.h),

          // Send Reset Link Button
          AuthButton(
            text: 'Send Reset Link',
            onPressed: _handleSendResetLink,
            isLoading: _isLoading,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent(ThemeHelper colors) {
    return Column(
      children: [
        // Success Icon
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: ColorManager.success.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.mark_email_read_outlined,
            size: 40.sp,
            color: ColorManager.success,
          ),
        ),

        SizedBox(height: 24.h),

        Text(
          'Check Your Email',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s20,
            fontWeight: FontWeightManager.bold,
            color: colors.textPrimary,
          ),
        ),

        SizedBox(height: 12.h),

        Text(
          'We\'ve sent a password reset link to',
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: colors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 4.h),

        Text(
          _emailController.text,
          style: FontConstants.getPoppinsStyle(
            fontSize: FontSize.s15,
            fontWeight: FontWeightManager.semiBold,
            color: ColorManager.primary,
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 24.h),

        // Info Box
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: colors.info.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: colors.info.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20.sp,
                color: colors.info,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Please check your spam folder if you don\'t see the email in your inbox.',
                  style: FontConstants.getPoppinsStyle(
                    fontSize: FontSize.s13,
                    fontWeight: FontWeightManager.regular,
                    color: colors.info,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        // Resend Link Button
        GestureDetector(
          onTap: _isLoading ? null : _handleResendLink,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                SizedBox(
                  width: 16.w,
                  height: 16.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(ColorManager.primary),
                  ),
                )
              else
                Icon(
                  Icons.refresh,
                  size: 18.sp,
                  color: ColorManager.primary,
                ),
              SizedBox(width: 8.w),
              Text(
                _isLoading ? 'Sending...' : 'Resend Link',
                style: FontConstants.getPoppinsStyle(
                  fontSize: FontSize.s14,
                  fontWeight: FontWeightManager.semiBold,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
