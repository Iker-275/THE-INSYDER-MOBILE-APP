import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insyder/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../core/bloc/auth/auth_bloc.dart';
import '../../core/utils/launch_storage.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_textfields.dart';

import '../../../../core/bloc/base_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isAuthor = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final userData = {
        'name': _nameCtrl.text.trim(),
        'email': _emailCtrl.text.trim(),
        'password': _passwordCtrl.text.trim(),
        'isAuthor': _isAuthor,
      };

      context.read<AuthBloc>().add(RegisterRequested(userData));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium!.color;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, BaseState<Map<String, dynamic>>>(
          listener: (context, state) {
            if (state == BaseState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? "Error occurred")),
              );
            }
            if (state == BaseState.success &&
                state.data?['registered'] == true) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Account created successfully")),
              );
              // Navigator.pop(context);
              LaunchStorage.setFirstLaunchDone();
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
          },
          builder: (context, state) {
            final isLoading = state == BaseState.loading;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 36.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      "Create Account",
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Join the INSYDER community",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: textColor?.withOpacity(0.7),
                      ),
                    ),
                    SizedBox(height: 40.h),

                    CustomTextField(
                      controller: _nameCtrl,
                      label: "Full Name",
                      hintText: "Enter your name",
                      validator: (value) =>
                          value == null || value.isEmpty ? "Required" : null,
                    ),
                    SizedBox(height: 20.h),

                    CustomTextField(
                      controller: _emailCtrl,
                      label: "Email",
                      hintText: "example@mail.com",
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    CustomTextField(
                      controller: _passwordCtrl,
                      label: "Password",
                      hintText: "Enter password",
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: textColor?.withOpacity(0.7),
                        ),
                        onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        if (value.length < 6) {
                          return "At least 6 characters required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Switch for author
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Switch(
                          value: _isAuthor,
                          activeColor: AppColors.lightPrimary,
                          onChanged: (val) => setState(() => _isAuthor = val),
                        ),
                        Text(
                          _isAuthor ? "Register as Author" : "Register as User",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: textColor?.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),

                    CustomButton(
                      text: isLoading ? "Creating..." : "Sign Up",
                      onPressed: isLoading ? null : _onSubmit,
                    ),

                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.login),
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: textColor?.withOpacity(0.7),
                          ),
                          children: [
                            TextSpan(
                              text: "Log in",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppColors.lightPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
