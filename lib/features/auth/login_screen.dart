import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_router.dart';
import '../../core/bloc/auth/auth_bloc.dart';
import '../../widgets/auth_header.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_textfields.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/bloc/base_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginRequested(
            _email.text.trim(),
            _password.text.trim(),
          ));
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, BaseState<Map<String, dynamic>>>(
        listener: (context, state) {
          if (state == BaseState.success && state.data?['loggedIn'] == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful!')),
            );
            // TODO: Navigate to home page
            Navigator.pushNamed(context, AppRoutes.home);
          } else if (state == BaseState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Something went wrong')),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state == BaseState.loading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const AuthHeader(
                      title: 'Welcome Back',
                      subtitle: 'Sign in to continue reading INSYDER Magazine',
                    ),
                    AuthTextField(
                      label: 'Email',
                      hint: 'you@example.com',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email_outlined,
                      validator: (v) => v == null || !v.contains('@')
                          ? 'Enter a valid email'
                          : null,
                    ),
                    AuthTextField(
                      label: 'Password',
                      hint: '••••••••',
                      controller: _password,
                      obscure: true,
                      icon: Icons.lock_outline_rounded,
                      validator: (v) => v == null || v.length < 6
                          ? 'Minimum 6 characters'
                          : null,
                    ),
                    SizedBox(height: 20.h),
                    PrimaryButton(
                      label: 'Sign In',
                      onPressed: isLoading ? () {} : () => _submit(context),
                      loading: isLoading,
                    ),
                    SizedBox(height: 12.h),
                    TextButton(
                      onPressed: () {}, // TODO: Forgot Password page
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to Sign Up
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.7),
                            fontSize: 14.sp,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
