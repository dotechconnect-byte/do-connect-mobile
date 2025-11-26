import 'package:do_connect/core/widgets/custom_text_field.dart';
import 'package:do_connect/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../pages/signup_screen.dart';

class SignupForm extends StatefulWidget {
  final SignupType signupType;

  const SignupForm({
    super.key,
    required this.signupType,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _accessCodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _positionController = TextEditingController();
  final _addressController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  String _selectedAccountType = 'Personal';

  @override
  void dispose() {
    _accessCodeController.dispose();
    _nameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _positionController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please accept the Terms and Conditions'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      print('Signup attempt:');
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Type: ${widget.signupType}');
    }
  }

  void _handleForgotPassword() {
    print('Forgot password tapped');
  }

  bool get _isDemoSignup => widget.signupType == SignupType.demo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isDemoSignup ? 'Request a Demo' : 'Sign Up',
            style: TextStyle(
              fontSize: (size.width * 0.048).clamp(18.0, 22.0),
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: size.height * 0.004),
          Text(
            _isDemoSignup
                ? "Fill in your details and we'll reach out to you"
                : 'Create your Do Connect profile',
            style: TextStyle(
              fontSize: (size.width * 0.03).clamp(11.5, 13.0),
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: size.height * 0.02),

          // Access Code Field (only for accessCode signup)
          if (!_isDemoSignup) ...[
            _buildLabel('Access Code *', size),
            SizedBox(height: size.height * 0.008),
            CustomTextField(
              controller: _accessCodeController,
              hintText: 'Enter your access code',
              prefixIcon: Icons.vpn_key_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your access code';
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.018),
          ],

          // Name Field
          _buildLabel('Name *', size),
          SizedBox(height: size.height * 0.008),
          CustomTextField(
            controller: _nameController,
            hintText: 'Your full name',
            prefixIcon: Icons.person_outline,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.018),

          // Email and Contact fields (position changes based on type)
          if (!_isDemoSignup) ...[
            _buildLabel('Contact Number *', size),
            SizedBox(height: size.height * 0.008),
            CustomTextField(
              controller: _contactController,
              hintText: 'Your contact number',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your contact number';
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.018),
            _buildLabel('Email *', size),
            SizedBox(height: size.height * 0.008),
            CustomTextField(
              controller: _emailController,
              hintText: 'your@email.com',
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
            SizedBox(height: size.height * 0.018),
          ] else ...[
            _buildLabel('Email *', size),
            SizedBox(height: size.height * 0.008),
            CustomTextField(
              controller: _emailController,
              hintText: 'your@email.com',
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
            SizedBox(height: size.height * 0.018),
            _buildLabel('Contact Number *', size),
            SizedBox(height: size.height * 0.008),
            CustomTextField(
              controller: _contactController,
              hintText: 'Your contact number',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your contact number';
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.018),
          ],

          // Address Field (only for demo)
          if (_isDemoSignup) ...[
            _buildLabel('Address *', size),
            SizedBox(height: size.height * 0.008),
            CustomTextField(
              controller: _addressController,
              hintText: 'Your address',
              prefixIcon: Icons.location_on_outlined,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.018),
          ],

          // Position Field (only for accessCode)
          if (!_isDemoSignup) ...[
            _buildLabel('Position *', size),
            SizedBox(height: size.height * 0.008),
            CustomTextField(
              controller: _positionController,
              hintText: 'Your position',
              prefixIcon: Icons.work_outline,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your position';
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.018),
          ],

          // Account Type (only for demo)
          if (_isDemoSignup) ...[
            _buildLabel('Account Type *', size),
            SizedBox(height: size.height * 0.008),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedAccountType = 'Personal';
                      });
                    },
                    child: Row(
                      children: [
                        Radio<String>(
                          value: 'Personal',
                          groupValue: _selectedAccountType,
                          onChanged: (value) {
                            setState(() {
                              _selectedAccountType = value!;
                            });
                          },
                          activeColor: const Color(0xFFFF7A29),
                        ),
                        Text(
                          'Personal',
                          style: TextStyle(
                            fontSize: (size.width * 0.035).clamp(13.0, 14.5),
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedAccountType = 'Company';
                      });
                    },
                    child: Row(
                      children: [
                        Radio<String>(
                          value: 'Company',
                          groupValue: _selectedAccountType,
                          onChanged: (value) {
                            setState(() {
                              _selectedAccountType = value!;
                            });
                          },
                          activeColor: const Color(0xFFFF7A29),
                        ),
                        Text(
                          'Company',
                          style: TextStyle(
                            fontSize: (size.width * 0.035).clamp(13.0, 14.5),
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_selectedAccountType == 'Company') ...[
              SizedBox(height: size.height * 0.018),
              _buildLabel('Position', size),
              SizedBox(height: size.height * 0.008),
              CustomTextField(
                controller: _positionController,
                hintText: 'Your position',
                prefixIcon: Icons.work_outline,
              ),
              SizedBox(height: size.height * 0.018),
              _buildLabel('Company Name', size),
              SizedBox(height: size.height * 0.008),
              CustomTextField(
                controller: _companyNameController,
                hintText: 'Your company name',
                prefixIcon: Icons.business_outlined,
              ),
              SizedBox(height: size.height * 0.018),
              _buildLabel('Website', size),
              SizedBox(height: size.height * 0.008),
              CustomTextField(
                controller: _websiteController,
                hintText: 'https://yourcompany.com',
                prefixIcon: Icons.language_outlined,
                keyboardType: TextInputType.url,
              ),
            ],
            SizedBox(height: size.height * 0.018),
          ],

          // Password Field
          _buildLabel('Password *', size),
          SizedBox(height: size.height * 0.008),
          CustomTextField(
            controller: _passwordController,
            hintText: 'Enter your password',
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
          SizedBox(height: size.height * 0.018),

          // Confirm Password Field
          _buildLabel('Confirm Password *', size),
          SizedBox(height: size.height * 0.008),
          CustomTextField(
            controller: _confirmPasswordController,
            hintText: 'Confirm your password',
            prefixIcon: Icons.lock_outlined,
            obscureText: _obscureConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.02),

          // Terms and Conditions Checkbox
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: _acceptTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptTerms = value ?? false;
                  });
                },
                activeColor: const Color(0xFFFF7A29),
                shape: const CircleBorder(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: size.height * 0.01),
                  child: RichText(
                    text: TextSpan(
                      text: 'I accept the ',
                      style: TextStyle(
                        fontSize: (size.width * 0.03).clamp(11.5, 13.0),
                        color: Colors.black87,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Terms and Conditions',
                          style: TextStyle(
                            color: Color(0xFFFF7A29),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: Color(0xFFFF7A29),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),

          // Signup Button
          PrimaryButton(
            text: _isDemoSignup ? 'Request Demo' : 'Create Profile',
            onPressed: _handleSignup,
          ),

          SizedBox(height: size.height * 0.015),

          // Forgot Password Link
          Center(
            child: TextButton(
              onPressed: _handleForgotPassword,
              child: Text(
                'Forgot password?',
                style: TextStyle(
                  fontSize: (size.width * 0.035).clamp(13.0, 14.5),
                  color: const Color(0xFFFF7A29),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text, Size size) {
    return Text(
      text,
      style: TextStyle(
        fontSize: (size.width * 0.035).clamp(13.0, 15.0),
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }
}
